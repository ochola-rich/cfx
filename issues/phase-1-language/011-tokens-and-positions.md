# [Phase 1] #011: Lexical Token Types with Source Position Tracking

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `lexer`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
Friendly diagnostics and source code mapping depend directly on precise position tracking during lexical analysis. Every token must retain its starting line, starting column, ending position, and byte offset in the source script.

## 2. Objective
Implement the `token` package in `internal/language/compile/token/` defining token constants, keyword mappings, position coordinates, and string formatting helpers.

## 3. Acceptance Criteria
- [ ] `Position` struct implemented:
  - `Line int` (1-based)
  - `Column int` (1-based)
  - `Offset int` (0-based byte offset)
- [ ] `Token` struct implemented containing `Type`, `Literal`, and `Pos Position`.
- [ ] Token types defined for:
  - Keywords: `CANVAS`, `BACKGROUND`, `DRAW`, `CIRCLE`, `RECTANGLE`, `LINE`, `REPEAT`, `TIMES`, `END`, `SET`, `TO`, `AT`, `WITH`, `COLORED`, `SIZED`, `RADIUS`, `OPACITY`
  - Dynamic identifiers / variables: `IDENT` (including built-ins: `time`, `mouse_x`, `mouse_y`, `width`, `height`, `i`)
  - Literals: `NUMBER` (integers and floats), `STRING`, `COLOR` (hex colors `#fff`, `#ff00aa` and named CSS colors)
  - Operators & Delimiters: `PLUS`, `MINUS`, `STAR`, `SLASH`, `COMMA`, `LPAREN`, `RPAREN`, `NEWLINE`, `EOF`, `ILLEGAL`
- [ ] Helper method `token.Lookup(ident string) TokenType` for keyword recognition.

## 4. Definition of Done (DoD)
- [ ] Package `internal/language/compile/token` fully implemented.
- [ ] Unit tests verify token string representations and keyword lookups.
- [ ] 100% test coverage on `token` package.
