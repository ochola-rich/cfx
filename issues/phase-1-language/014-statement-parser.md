# [Phase 1] #014: Statement Recursive-Descent Parser

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `parser`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The parser consumes tokens from the Lexer and constructs an AST. It uses recursive descent to handle top-level statements and block constructs (`repeat ... end`), collecting diagnostics instead of failing on the first error to allow multi-error reporting in the Studio editor.

## 2. Objective
Implement `internal/language/compile/parser/statement.go` to parse all core drawing and control statements with error recovery.

## 3. Acceptance Criteria
- [ ] Parser parses:
  - `canvas <width> by <height>`
  - `background <color>`
  - Shape statements: `circle`, `rectangle`, `line`
  - Blocks: `repeat <count> times ... end`
  - Assignments: `set <ident> to <expr>`
- [ ] Handles missing tokens gracefully without panicking (e.g. missing `end` for a `repeat` block emits a clear diagnostic at the block start).
- [ ] Error synchronization / recovery: on unexpected token, recovers at next newline or recognized keyword statement so subsequent statements are still parsed.
- [ ] Comprehensive unit tests verifying valid AST construction for each statement type.

## 4. Definition of Done (DoD)
- [ ] Statement parsing logic implemented and tested.
- [ ] Unit tests in `parser_test.go` achieve >85% coverage on statement parsing.
