# [Phase 1] #018: Execution & Resource Limits Enforcement in Scene IR

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `security`, `dos-prevention`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
To prevent malicious or accidental denial-of-service (such as memory exhaustion, browser tab freezes, or CPU spikes), strict resource limits must be enforced during compilation before generating a Scene IR.

## 2. Objective
Implement deterministic safety limits in `internal/language/scene/limits.go` and enforce them during scene construction (`NewScene`).

## 3. Acceptance Criteria
- [ ] Explicit maximum resource thresholds defined:
  - **Max Canvas Dimensions**: e.g., max 4096 x 4096 px (min 10 x 10 px).
  - **Max Loop Iterations**: e.g., max 1,000 iterations per single repeat block; static loop counts bounded.
  - **Max Nesting Depth**: e.g., max 4 levels of nested repeat blocks.
  - **Max Total Render Nodes**: e.g., max 2,500 total shape instances per frame.
  - **Max Expression Complexity**: limit expression tree depth (e.g. max 20 operators deep).
- [ ] `scene.New(...)` validates all thresholds:
  - Exceeding any limit immediately terminates compilation and returns a diagnostic:
    - `"resource limit exceeded: loop iteration count 100000 exceeds maximum allowable 1000"`.
- [ ] Unit tests verify all boundary conditions (at limit = success, at limit + 1 = diagnostic error).

## 4. Definition of Done (DoD)
- [ ] Limits constants and validation logic implemented in `internal/language/scene/limits.go`.
- [ ] Boundary tests written and passing.
