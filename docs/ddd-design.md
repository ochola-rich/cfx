# DDD Design

## Strategic Design

### Subdomains: Where to Invest

| Subdomain | Type | Why |
|-----------|------|-----|
| **Visual language** (plain English to safe scene) | **Core** | This is what no one else has. Model it most carefully. |
| **Playback** (scene to pixels) | **Core** | The performance and safety promise lives here. |
| **Publishing** (artworks, versions, embeds) | Supporting | Necessary, but not a differentiator. |
| **Identity** (who is the creator) | Generic | Buy or use OIDC. Don't model it deeply. |
| Hosting, CDN, storage | Generic | Infrastructure. |

### Bounded Contexts

1. **Language**: turns a creator's script into a validated Scene, or into diagnostics that say what to fix.
2. **Playback**: takes a Scene plus time and pointer position, and produces drawing. It is the JS runtime.
3. **Publishing**: owns artworks, their drafts, versions and public embed URLs.
4. **Identity**: creators and ownership. Minimal in v1.

The **Studio** is not a context. It is a client application that talks to the contexts.

### Context Map

```
 Identity ──(OIDC, Open Host)──► Publishing
 Language ──(Published Language: Scene schema v1)──► Playback   (Playback conforms)
 Language ──(Customer/Supplier)──► Publishing   (via an anti-corruption layer)
```

- The **Scene schema** is the *Published Language*. Language owns and versions it, and Playback conforms to it. This is the formal version of "the scene is the contract".
- Publishing never imports Language's internals. It defines its own `SceneCompiler` port and an adapter translates. If the language changes, only the adapter changes.

### Ubiquitous Language (Use These Words in Code, Docs and UI)

| Term | Meaning |
|------|---------|
| **Script** | The plain-English text a creator writes. |
| **Statement** | One instruction (`draw a circle ...`). |
| **Diagnostic** | A friendly message about a problem, with line and column. |
| **Scene** | The validated, immutable, portable result of compiling a script. |
| **Artwork** | A creator's piece, with a title, a draft and a history. |
| **Draft** | The working script, which may not compile yet. |
| **Version** | A published, immutable snapshot (script plus scene). |
| **Publish** | Turn the draft into a new version. |
| **Embed** | A public address that plays one version on any site. |

> **Never use "template", "project" or "file" casually.** Each means something different later.

## Tactical Design

### Language Context (Stateless, So No Aggregates)

Not everything needs an aggregate. Language is a pure transformation.

- **Value objects:** `Script`, `Diagnostic{Line, Column, Message, Hint}`, `Scene`, and the node types (`Circle`, `Rectangle`, `Line`, `Repeat`, `Background`).
- **Smart constructor:** `NewScene(...)` enforces the invariants: canvas ≤ 4000, loop iterations and node count capped. An invalid Scene cannot exist.
- **Domain service:** `Compile(Script) (Scene, []Diagnostic)`.
- **Internals:** lexer, parser, checker and emitter are implementation details behind that one service.

### Publishing Context (The Main Aggregate)

**Artwork** is the aggregate root:

- **Fields:** `ArtworkID`, `OwnerID`, `Title`, `Draft`, and a list of `Version` entities.
- **Invariants** (the root enforces these):
  - A published Version is immutable.
  - Version numbers are sequential.
  - Only the owner can change or publish.
  - A Version's scene hash must match the scene it was published with.
  - The title is not empty.
- **Behaviors, not setters:** `SaveDraft(script)`, `Publish(scene) → Version`, `Unpublish(versionNo)`.
- **Domain events:** `DraftSaved`, `VersionPublished`, `VersionUnpublished`.
- **Repository:** `ArtworkRepository` is an interface in the domain package. SQLite implements it in infrastructure.
- **Application service (use case):** `PublishArtwork` loads the aggregate, asks the compiler port for a Scene, calls `artwork.Publish(scene)`, saves, and emits events.

### Playback Context

A pure function: `Frame(scene, time, pointer) → draw operations`. There is no persistence. It stays in JS, and **shared golden fixtures** (script, scene JSON, expected draw ops) are tested in both Go and JS to keep the contract honest.

### Reads vs Writes (CQRS-lite)

The hot path is `GET /art/{id}.json`. It reads a flat, cacheable **read model** (the published scene), not the Artwork aggregate. Writes go through the aggregate, and a `VersionPublished` event updates the read model.

## Go Structure (One Module Per Context, Hexagonal Inside)

```
cmd/cfxd/                       composition root (wires everything)
internal/
  language/
    scene/                      Scene, nodes, limits (value objects)
    compile/                    lexer, parser, check, emit
    language.go                 public API: Compile(...)
  publishing/
    domain/                     Artwork, Version, events, repository interface
    app/                        commands and queries (use cases)
    ports/                      SceneCompiler interface (the ACL boundary)
    infra/sqlite/               repository implementation
    infra/languageadapter/      implements SceneCompiler by calling language
    http/                       handlers
  identity/                     minimal in v1
runtime/                        JS web component (Playback)
```

**Dependency rule:** domain code imports nothing from infrastructure, and contexts reach each other only through public APIs or ports.

## Where I'd Deliberately Stay Simple

Identity, hosting and the gallery listing are plain CRUD. Spending DDD effort there is waste. Model deeply only Language and Publishing.

## Next Steps

1. **Event storming** (a short list of domain events, commands and policies) to confirm the boundaries.
2. Then the **language grammar** and Scene schema, since Language is the core.

## Open Question

**Identity in v1?** Should Identity exist in v1 (creators sign in and own artworks), or should v1 be anonymous with a secret edit link? That decides whether Identity is a context now or a later add-on.