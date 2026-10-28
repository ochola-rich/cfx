# [Phase 3] #039: SceneCompiler Port & Language Anti-Corruption Layer (ACL)

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `ddd`, `architecture`, `acl`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
The Publishing bounded context must never directly import or depend on the internal compiler packages of the Language context. To insulate Publishing from changes to the compiler AST, tokens, or parser, Publishing defines its own `SceneCompiler` port (interface), and an Anti-Corruption Layer (ACL) adapter bridges the two domains.

## 2. Objective
Define the `SceneCompiler` port in `internal/publishing/ports/compiler.go` and implement the ACL adapter in `internal/publishing/infra/languageadapter/adapter.go`.

## 3. Acceptance Criteria
- [ ] Port definition in Publishing:
  ```go
  package ports

  type CompiledResult struct {
      SceneJSON []byte
      IRVersion int
      Errors    []CompilationError
  }

  type SceneCompiler interface {
      Compile(ctx context.Context, script string) (*CompiledResult, error)
  }
  ```
- [ ] Adapter implementation in `internal/publishing/infra/languageadapter/`:
  - Calls `language.Compile(script)` from the Language context.
  - Translates internal Language diagnostics into Publishing `CompilationError` value objects.
  - Serializes valid `scene.Scene` into canonical JSON bytes.
- [ ] Decoupling verification:
  - `internal/publishing/domain` and `internal/publishing/app` have zero imports of `internal/language/...`.

## 4. Definition of Done (DoD)
- [ ] Interface and adapter implemented.
- [ ] Unit tests verify proper data translation and error wrapping through the adapter.
