# [Phase 1] #020: Scene IR Emitter (Lowering AST to JSON Scene)

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `emitter`, `ir`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
Once an AST passes semantic checking and resource limits validation, the Emitter transforms the AST into the canonical, versioned Scene Intermediate Representation (`internal/language/scene/`). 

## 2. Objective
Implement `internal/language/compile/emitter/emitter.go` to convert validated AST statements and expressions into the runtime-ready Scene IR.

## 3. Acceptance Criteria
- [ ] Converts top-level statements:
  - `canvas` statement sets canvas width, height, and default background.
  - `background` statement emits background layer node.
  - `circle`, `rectangle`, `line` statements emit shape nodes with normalized coordinates and evaluated/symbolic properties.
  - `repeat` blocks are unrolled or lowered to loop nodes according to IR spec without exceeding limits.
  - Variable references and expressions are lowered to expression trees.
- [ ] Sets `"version": 1` in emitted Scene IR root.
- [ ] Emits deterministic JSON: identical source script always produces byte-identical Scene IR output.
- [ ] Optimizes static constant expressions during emission where possible (constant folding, e.g. `10 + 20` -> `30`).

## 4. Definition of Done (DoD)
- [ ] Emitter implemented in `internal/language/compile/emitter/`.
- [ ] Unit tests verify end-to-end AST to Scene IR translation.
- [ ] Emitted JSON passes `docs/scene-schema-v1.json` validation.
