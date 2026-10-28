# [Phase 1] #016: Pratt Expression Parser for Dynamic Formulas (No eval)

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `parser`, `security`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
Dynamic visuals require reactive formulas such as `sin(time * 2) * 50 + 200` or `mouse_x / width * 100`. 
To ensure deterministic execution, high performance, and absolute security (no `eval`, no code injection, no arbitrary JS execution), expressions must be parsed via a Top-Down Operator Precedence (Pratt) parser into a pure AST tree.

## 2. Objective
Implement a Pratt expression parser in `internal/language/compile/parser/expression.go` handling operators, precedence, parentheses, and math function calls.

## 3. Acceptance Criteria
- [ ] Pratt parser handles operator precedence correctly:
  - Parentheses: `(...)` (highest binding power)
  - Function calls: `sin(...)`, `cos(...)`, `min(...)`, `max(...)`, `floor(...)`, `ceil(...)`, `abs(...)`, `sqrt(...)`
  - Unary prefix: `-x`, `+x`
  - Multiplicative: `*`, `/`, `%`
  - Additive: `+`, `-`
  - Relational / comparisons (if used in expressions): `<`, `>`, `<=`, `>=`, `==`
- [ ] Strictly zero runtime `eval()` or string-to-code execution: expressions compile directly to serializable AST nodes.
- [ ] Handles syntax errors cleanly (e.g. mismatched parentheses `(10 + 2`, orphan operators `10 + * 2`) and emits precise diagnostics.
- [ ] Unit tests verify correct precedence trees for complex nested formulas (e.g. `2 + 3 * 4 == 14`, `sin(time) * (mouse_x + 10)`).

## 4. Definition of Done (DoD)
- [ ] Pratt parser implemented and passing comprehensive unit tests.
- [ ] Benchmark tests verify parsing speed meets target (>50,000 expressions/second).
