# [Phase 1] #013: Abstract Syntax Tree (AST) Node Types

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `ast`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The Abstract Syntax Tree (AST) represents the syntactic structure of a visual script in memory. Every AST node must implement a common `Node` interface and provide source coordinate mapping for error reporting and downstream tooling (such as visual inspector mappings).

## 2. Objective
Implement the `ast` package in `internal/language/compile/ast/` defining statements, expressions, and root script structures.

## 3. Acceptance Criteria
- [ ] Core interfaces defined:
  - `Node`: `Pos() token.Position`, `End() token.Position`, `String() string`
  - `Statement`: implements `Node`, `statementNode()`
  - `Expression`: implements `Node`, `expressionNode()`
- [ ] Root node:
  - `Script`: `Statements []Statement`
- [ ] Statement node types:
  - `CanvasStmt`: Width `Expression`, Height `Expression`
  - `BackgroundStmt`: Color `Expression`
  - `DrawStmt`: Shape `ShapeSpec`, Clauses `[]Clause` (position, size, fill, opacity, rotation)
  - `RepeatStmt`: Count `Expression`, IndexVar `string`, Body `[]Statement`
  - `SetStmt`: Variable `string`, Value `Expression`
- [ ] Expression node types:
  - `NumberLiteral`, `StringLiteral`, `ColorLiteral`, `Identifier`
  - `PrefixExpr`: Operator `string`, Right `Expression`
  - `InfixExpr`: Left `Expression`, Operator `string`, Right `Expression`
  - `CallExpr`: Function `string` (e.g. `sin`, `cos`, `random`), Args `[]Expression`
- [ ] Pretty-printing / `String()` methods for debugging and AST inspection.

## 4. Definition of Done (DoD)
- [ ] Package `internal/language/compile/ast` fully implemented.
- [ ] Tests verify `String()` and position retention across all node variants.
