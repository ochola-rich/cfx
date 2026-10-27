# Project Structure

## Repository Layout

```
cfx/
├── cmd/
│   └── cfxd/                 # Composition root (main entry point)
├── internal/
│   ├── language/             # Language context (core domain)
│   │   ├── scene/            # Scene, nodes, limits (value objects)
│   │   ├── compile/          # Lexer, parser, checker, emitter
│   │   └── language.go       # Public API: Compile(...)
│   ├── publishing/           # Publishing context (core domain)
│   │   ├── domain/           # Artwork, Version, events, repository interface
│   │   ├── app/              # Commands and queries (use cases)
│   │   ├── ports/            # SceneCompiler interface (ACL boundary)
│   │   ├── infra/
│   │   │   ├── sqlite/       # Repository implementation
│   │   │   └── languageadapter/ # Implements SceneCompiler by calling language
│   │   └── http/             # HTTP handlers
│   └── identity/             # Identity context (generic, minimal v1)
├── runtime/                  # JS web component (Playback context)
│   ├── src/
│   │   ├── element.ts        # <creative-canvas> custom element
│   │   ├── renderer.ts       # Frame(scene, time, pointer) → draw ops
│   │   └── scene.ts          # Scene types (shared with Go via codegen)
│   ├── test/
│   │   └── golden/           # Shared golden fixtures (script, scene, draw ops)
│   ├── package.json
│   └── rollup.config.js
├── docs/                     # Documentation (this folder)
├── go.mod
├── go.sum
├── Makefile
└── README.md
```

## Go Module Structure

### `cmd/cfxd`

- Wires all dependencies (DB, HTTP server, compiler, etc.)
- Single binary: `cfxd serve`, `cfxd migrate`, `cfxd version`

### `internal/language`

**Pure domain — no external dependencies**

```
internal/language/
├── scene/
│   ├── scene.go         # Scene, Canvas, Node types, limits, smart constructors
│   ├── nodes.go         # Circle, Rectangle, Line, Polygon, Repeat
│   └── limits.go        # MaxCanvasSize, MaxNodes, MaxRepeatIterations
├── compile/
│   ├── token/
│   │   └── token.go     # Token types, positions
│   ├── lexer/
│   │   └── lexer.go     # Text → tokens
│   ├── ast/
│   │   └── ast.go       # AST node types
│   ├── parser/
│   │   └── parser.go    # Tokens → AST (Pratt for expressions)
│   ├── check/
│   │   └── check.go     # Names, scopes, limits, diagnostics
│   └── emit/
│       └── emit.go      # AST → Scene IR
├── ir/
│   └── ir.go            # Scene IR types + JSON encoding
└── language.go          # Compile(script) (Scene, []Diagnostic)
```

### `internal/publishing`

**Hexagonal architecture**

```
internal/publishing/
├── domain/
│   ├── artwork.go       # Artwork aggregate root
│   ├── version.go       # Version entity
│   ├── events.go        # DraftSaved, VersionPublished, VersionUnpublished
│   └── repository.go    # ArtworkRepository interface
├── app/
│   ├── commands/
│   │   ├── save_draft.go
│   │   ├── publish.go
│   │   └── unpublish.go
│   └── queries/
│       ├── get_artwork.go
│       └── list_artworks.go
├── ports/
│   └── compiler.go      # SceneCompiler interface
├── infra/
│   ├── sqlite/
│   │   ├── repo.go      # ArtworkRepository impl
│   │   └── schema.sql
│   └── languageadapter/
│       └── adapter.go   # Implements SceneCompiler via language.Compile
└── http/
    ├── handlers.go
    ├── middleware.go
    └── routes.go
```

### `internal/identity`

Minimal in v1 — just enough to attach an owner to an artwork.

```
internal/identity/
├── user.go
├── auth.go
└── oidc.go
```

## Runtime (JavaScript)

```
runtime/
├── src/
│   ├── element.ts       # Custom element: <creative-canvas>
│   ├── renderer.ts      # Pure function: draw(ctx, scene, time, pointer)
│   ├── scene.ts         # TypeScript types matching Go Scene IR
│   └── index.ts         # Entry point, registers custom element
├── test/
│   ├── golden/
│   │   ├── fixtures/    # .cfx scripts + expected scene.json + draw ops
│   │   └── runner.ts    # Runs golden tests in Node + browser
│   └── snapshot/        # Visual regression tests
├── package.json
├── tsconfig.json
├── rollup.config.js     # Bundles to embed.js (~3-10KB min+gzip)
└── README.md
```

## Dependency Rules

```
┌─────────────────────────────────────────────────────────┐
│  cmd/cfxd                                               │
│  └── imports: internal/publishing, internal/language    │
├─────────────────────────────────────────────────────────┤
│  internal/publishing/http                               │
│  └── imports: internal/publishing/app, internal/publishing/domain │
├─────────────────────────────────────────────────────────┤
│  internal/publishing/app                                │
│  └── imports: internal/publishing/domain, internal/publishing/ports │
├─────────────────────────────────────────────────────────┤
│  internal/publishing/domain                             │
│  └── imports: internal/publishing/ports (interfaces only)           │
├─────────────────────────────────────────────────────────┤
│  internal/publishing/infra/languageadapter              │
│  └── imports: internal/language, internal/publishing/ports          │
├─────────────────────────────────────────────────────────┤
│  internal/language                                       │
│  └── imports: (nothing outside internal/language)       │
├─────────────────────────────────────────────────────────┤
│  internal/identity                                       │
│  └── imports: (minimal, no domain deps)                 │
└─────────────────────────────────────────────────────────┘
```

**Key rule:** Domain code (`domain/`, `language/`) imports **nothing** from infrastructure (`infra/`, `http/`, `sqlite/`). Contexts reach each other only through public APIs or ports.

## Build & Test Commands

```bash
# Go
make build           # Build cfxd binary
make test            # Run all Go tests
make test-language   # Language golden tests
make test-publishing # Publishing unit tests
make lint            # golangci-lint

# Runtime (JS)
cd runtime
npm install
npm run build        # Outputs embed.js + embed.js.map
npm run test         # Golden + snapshot tests
npm run test:watch

# Full stack
make dev             # Starts cfxd + runtime dev server
```

## Golden Test Fixtures (Shared Go ↔ JS)

```
runtime/test/golden/fixtures/
├── 01_basic_circle/
│   ├── source.cfx
│   ├── scene.json
│   └── drawops.json
├── 02_repeat_wave/
│   ├── source.cfx
│   ├── scene.json
│   └── drawops.json
└── ...

# Go test loads .cfx → compiles → compares scene.json
# JS test loads scene.json → renders → compares drawops.json
```

## Database Schema (SQLite)

```sql
-- Artworks table
CREATE TABLE artworks (
    id TEXT PRIMARY KEY,
    owner_id TEXT NOT NULL,
    title TEXT NOT NULL,
    draft TEXT NOT NULL DEFAULT '',
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- Versions table (immutable)
CREATE TABLE versions (
    artwork_id TEXT NOT NULL,
    version INTEGER NOT NULL,
    source TEXT NOT NULL,
    scene_json TEXT NOT NULL,
    scene_hash TEXT NOT NULL,
    ir_version INTEGER NOT NULL DEFAULT 1,
    published_at TEXT NOT NULL,
    PRIMARY KEY (artwork_id, version),
    FOREIGN KEY (artwork_id) REFERENCES artworks(id)
);

-- Read model for hot path (denormalized, updated by VersionPublished event)
CREATE TABLE published_scenes (
    artwork_id TEXT PRIMARY KEY,
    version INTEGER NOT NULL,
    scene_json TEXT NOT NULL,
    ir_version INTEGER NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(id)
);

-- Index for gallery listing
CREATE INDEX idx_artworks_owner ON artworks(owner_id);
CREATE INDEX idx_artworks_updated ON artworks(updated_at DESC);
```