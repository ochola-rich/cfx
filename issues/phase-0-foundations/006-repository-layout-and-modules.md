# [Phase 0] #006: Repository Module Layout & Package Scaffolding

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `infrastructure`, `golang`, `typescript`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
To enforce the bounded contexts identified in the DDD design, the repository directory layout must enforce clean dependency boundaries:
- `internal/language`: Core Domain (pure Go, zero external dependencies, no database or HTTP imports).
- `internal/publishing`: Core Domain & Application services for managing artworks, drafts, and versions.
- `internal/publishing/ports`: Abstract interfaces (e.g. `SceneCompiler`, `ArtworkRepository`).
- `internal/publishing/infra`: Infrastructure implementations (SQLite storage, Language ACL adapter).
- `cmd/cfxd`: Composition root wiring HTTP handlers, database connections, and adapters together into a runnable daemon.
- `runtime/`: TypeScript playback web component and sandboxed canvas renderer.

## 2. Objective
Scaffold the full directory structure, initialize Go modules, establish package skeletons with basic stub exports, and set up the TypeScript package for the runtime.

## 3. Acceptance Criteria
- [ ] Directory layout created in accordance with `docs/project-structure.md`:
  - `cmd/cfxd/main.go` (CLI entry point)
  - `internal/language/scene/`
  - `internal/language/compile/`
  - `internal/language/language.go`
  - `internal/publishing/domain/`
  - `internal/publishing/app/`
  - `internal/publishing/ports/`
  - `internal/publishing/infra/sqlite/`
  - `internal/publishing/infra/languageadapter/`
  - `internal/publishing/http/`
  - `internal/identity/`
  - `runtime/src/`
  - `runtime/test/`
- [ ] Root `go.mod` configured with Go 1.22+ and verified with `go vet ./...`.
- [ ] `runtime/package.json` created with minimal build configuration (Rollup or esbuild or Vite, TypeScript, Vitest).
- [ ] Architectural boundary test or rule documented preventing `internal/language` from importing `internal/publishing` or `database/sql`.

## 4. Definition of Done (DoD)
- [ ] All directories created with initial `.gitkeep` or stub `.go` / `.ts` files.
- [ ] `go build ./cmd/cfxd` compiles successfully without errors.
- [ ] `npm install` inside `runtime/` runs without errors.
