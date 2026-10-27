# Design, Version 1

## Principles

1. **The scene is the contract.** The language compiles to a versioned JSON scene (the IR, or intermediate representation). Language, studio and runtime can each change independently.
2. **A closed language.** Creators can only say what the language allows, so safety comes from the design, not from filtering.
3. **Compile once, run anywhere.** Embeds never receive source code, only scenes.
4. **Pure rendering.** The runtime computes `draw(scene, time, mouse)` and nothing else.

## Architecture

```
 Studio (editor, layers, preview)
        │ source text
        ▼
 Compiler (Go):  lex → parse → check → emit
        │ Scene IR (versioned JSON)
        ▼
 Platform (Go):  store, versions, gallery, embed API
        │ GET /art/{id}.json
        ▼
 Runtime (JS web component, ~3-10KB): <creative-canvas src=...>
```

## Domain Model

- **Artwork:** id, title, owner, created date
- **Version:** source text, compiled scene, IR version, created date. Scenes are immutable once published.
- **Scene (IR):** canvas size plus a tree of nodes (`shape`, `repeat`, `background`)
- **Embed:** a public URL for a specific artwork version

## Compiler Stages (Go Packages)

```
internal/lang/token    token types and positions
internal/lang/lexer    text → tokens
internal/lang/ast      node types
internal/lang/parser   tokens → AST (recursive descent, Pratt for math)
internal/lang/check    names, scopes, limits, friendly errors
internal/ir            scene types and JSON encoding
internal/emit          AST → IR
```

Each stage has one job, takes one input, and returns errors with line and column.

## Runtime Contract

- **Input:** a scene, `time`, and pointer position
- **Output:** draw operations on a canvas
- No network, no DOM access, no `eval`. Loops and sizes are capped.
- **Element API:** `src`, `paused`, `load(scene)`, `pause()`, `resume()`

## Platform API (First Cut)

| Endpoint | Purpose |
|----------|---------|
| `POST /compile` | source → scene or errors (used by the studio) |
| `POST /artworks` | save a new artwork and its first version |
| `PUT /artworks/{id}` | add a version |
| `GET /art/{id}.json` | the scene an embed loads (cacheable) |
| `GET /embed.js` | the runtime |

## Quality Requirements That Shape the Design

- **Performance budget:** runtime under 10KB, with a frame budget that holds on low-end phones
- **Security:** an allow-list language, resource limits, and the server re-validating every scene before publishing
- **Evolvability:** the IR carries a version number, and old scenes keep rendering
- **Testability:** golden tests (source in, scene out) for the compiler, and snapshot tests for the runtime

## Open Decisions to Settle Next

1. **Accounts:** anonymous publishing, or sign-in for owned artworks?
2. **Storage:** SQLite to start, or Postgres from day one?
3. **Hosting model:** a hosted platform, a self-hostable binary, or both?

## Proposed Next Step

Design the language itself: a formal grammar (EBNF) and the AST node types. Everything else depends on it.