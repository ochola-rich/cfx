# [Phase 1] #023: Public Language Context API: Compile(Script) (Scene, []Diagnostic)

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `api`, `compiler`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The Language bounded context must expose a clean, minimal, non-leaking public Go API. Internal compiler details (lexer, AST nodes, parser tokens, emitter internals) must remain private (`internal/language/compile/...`), exposing only the public entry point and value objects at `internal/language/language.go`.

## 2. Objective
Implement and expose the public function:
`func Compile(script string) (*scene.Scene, []diagnostic.Diagnostic)` in `internal/language/language.go`.

## 3. Acceptance Criteria
- [ ] Public signature:
  ```go
  package language

  func Compile(script string) (*scene.Scene, []diagnostic.Diagnostic)
  ```
- [ ] Behavior:
  - If script compiles cleanly: returns non-nil `*scene.Scene` and empty diagnostics slice `nil`.
  - If script contains syntax/semantic errors: returns `nil` Scene and slice of `diagnostic.Diagnostic` describing all encountered issues.
  - If warnings occur: returns valid `*scene.Scene` along with non-fatal diagnostics.
- [ ] Thread safety:
  - `Compile(...)` is stateless and completely safe for concurrent invocation across goroutines.
- [ ] High performance benchmark:
  - Standard 50-line script compiles in < 5ms on standard hardware.
- [ ] Package documentation (`godoc`) complete with usage examples.

## 4. Definition of Done (DoD)
- [ ] `internal/language/language.go` implemented and exported.
- [ ] End-to-end unit tests and benchmarks pass in `internal/language/language_test.go`.
- [ ] External packages can only interact with Language context through this API.
