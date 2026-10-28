# [Phase 1] #021: Comprehensive Golden Testing Suite (Scripts to Scene IR)

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `testing`, `compiler`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
Compiler regressions can subtly break downstream rendering. Golden testing ensures stability by executing a battery of `.cfx` input scripts and asserting exact matches against checked-in `.golden.json` Scene IR outputs and `.golden.err` diagnostic outputs.

## 2. Objective
Build an automated golden test runner in `internal/language/compile/golden_test.go` reading from `testdata/golden/`.

## 3. Acceptance Criteria
- [ ] Golden test runner automatically scans `testdata/golden/` directory for test cases:
  - Valid cases: `<name>.cfx` must produce byte-for-byte identical output matching `<name>.golden.json`.
  - Invalid cases: `<name>.bad.cfx` must produce diagnostics matching `<name>.golden.diag`.
- [ ] Golden suite includes diverse script samples:
  - Hello visual: 1-line circle script.
  - Geometry: combinations of circles, rectangles, lines, colors, and opacity.
  - Motion / dynamic expressions: `sin(time)`, `mouse_x`, `mouse_y`.
  - Nested loops: `repeat 10 times ... repeat 5 times ... end end`.
  - Error cases: syntax error, unclosed loop, resource limit exceeded, unknown keyword.
- [ ] Supports `-update` flag in Go test command (`go test ./... -update`) to cleanly regenerate golden files when schemas deliberately change.

## 4. Definition of Done (DoD)
- [ ] Test harness implemented and at least 15 distinct golden test pairs committed.
- [ ] All golden tests pass in CI.
