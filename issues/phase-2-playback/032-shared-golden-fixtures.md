# [Phase 2] #032: Cross-Language Shared Golden Test Fixtures (Go & TypeScript)

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `testing`, `cross-platform`, `contract`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
The Go compiler produces Scene IR JSON, and the TypeScript runtime executes Scene IR JSON. If either context diverges in interpreting numeric values, loop bounds, operator precedence, or node properties, visual output will be corrupted. Shared golden fixtures guarantee cross-language parity.

## 2. Objective
Create a shared fixtures directory (`runtime/test/golden/`) and automated test suites executed by both Go (`go test`) and TypeScript (`vitest`) that validate identical evaluation outputs.

## 3. Acceptance Criteria
- [ ] Central fixture repository established at `runtime/test/golden/`:
  - Each fixture contains:
    - `input.cfx`: the source script
    - `scene.json`: compiled Scene IR
    - `frame_0.json`: expected draw operations / evaluated nodes at `time = 0`
    - `frame_1.json`: expected draw operations at `time = 1.0, mouse = (100, 200)`
- [ ] **Go test runner** validates that compiling `input.cfx` produces matching `scene.json`.
- [ ] **TypeScript test runner** validates that evaluating `scene.json` at the given timestamps produces the identical sequence of draw calls in `frame_0.json` and `frame_1.json`.
- [ ] Shared fixtures included in continuous integration pipeline for both languages.

## 4. Definition of Done (DoD)
- [ ] At least 10 comprehensive cross-language fixtures committed.
- [ ] Both `go test ./...` and `npm test` execute and pass against the identical test files.
