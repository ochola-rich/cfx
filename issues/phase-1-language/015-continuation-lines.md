# [Phase 1] #015: Continuation Line Syntax Support for Property Clauses

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `parser`, `ux`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
Creators naturally format readable scripts across multiple lines:
```cfx
circle
  at 200, 300
  radius 50
  colored #ff0055
  opacity 0.8
```
The parser must support natural continuation lines without requiring backslashes (`\`) or commas at line endings.

## 2. Objective
Implement newline-insensitive continuation clause parsing in the statement parser so property clauses (`at`, `radius`, `sized`, `colored`, `opacity`, `rotated`, `stroke`) can span multiple lines seamlessly.

## 3. Acceptance Criteria
- [ ] Parser treats leading clause keywords (`at`, `radius`, `sized`, `colored`, `opacity`, `rotated`, `stroke`, `with`) as continuations of the preceding statement if separated by newlines and indentation.
- [ ] Multiple property clauses can be written either on the same line or split across separate lines:
  - Example single line: `circle at 100, 100 radius 20 colored blue`
  - Example multi-line:
    ```
    circle
      at 100, 100
      radius 20
      colored blue
    ```
- [ ] A new statement keyword (`circle`, `rectangle`, `repeat`, `set`, `background`, `canvas`) immediately terminates any active continuation block.
- [ ] Property clause collisions (e.g. defining `radius` twice on the same circle) emit a warning or diagnostic.

## 4. Definition of Done (DoD)
- [ ] Continuation line parsing implemented in `internal/language/compile/parser/`.
- [ ] Tests verify single-line and multi-line formatting parse to identical AST structures.
