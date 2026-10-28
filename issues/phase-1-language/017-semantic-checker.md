# [Phase 1] #017: Semantic Checker & Scope Resolution

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `semantic-analysis`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
Syntactically valid scripts can still contain semantic errors, such as referencing an undefined variable, re-declaring loop counters, modifying read-only built-in variables (`time = 5`), or shadowing reserved words. The Semantic Checker inspects the AST before emission and validates scopes and types.

## 2. Objective
Implement `internal/language/compile/checker/checker.go` to validate symbols, lexical scoping, variable mutability, and type consistency.

## 3. Acceptance Criteria
- [ ] Built-in system variables recognized and protected:
  - Read-only variables: `time`, `width`, `height`, `mouse_x`, `mouse_y`
  - Attempting to overwrite a read-only variable (e.g. `set time to 10`) produces a clear diagnostic: `"cannot assign to read-only built-in variable 'time'"`.
- [ ] Loop variables (e.g. `i` or explicit counter names) scoped strictly to their enclosing `repeat` block.
- [ ] Undefined variable access produces a diagnostic with line, column, and identifier name.
- [ ] Variable redeclarations and shadowing detected according to defined language scoping rules.
- [ ] Type validation:
  - Color properties accept valid color expressions or hex codes, not arbitrary arithmetic expressions.
  - Dimensions (radius, width, height) must evaluate to positive numeric values.

## 4. Definition of Done (DoD)
- [ ] Checker implemented in `internal/language/compile/checker/`.
- [ ] Test suite verifies diagnostic emission for all semantic violation cases.
