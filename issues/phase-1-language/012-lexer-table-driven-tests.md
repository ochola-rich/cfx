# [Phase 1] #012: Lexer Implementation with Table-Driven Tests

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `lexer`, `testing`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The Lexer (scanner) converts raw UTF-8 input script into a stream of tokens. It must handle whitespace, newlines, comments (e.g. `-- comment` or `// comment`), numeric formats (integers, decimals), colors, identifiers, and emit meaningful `ILLEGAL` tokens with positions when unrecognized characters are encountered without crashing.

## 2. Objective
Implement `internal/language/compile/lexer/lexer.go` with a comprehensive suite of table-driven tests.

## 3. Acceptance Criteria
- [ ] `Lexer` struct initialized via `New(input string) *Lexer`.
- [ ] `NextToken() token.Token` accurately scans the next token from input:
  - Correctly advances line and column counters across single and multi-byte UTF-8 runes.
  - Recognizes integers (`42`) and floating-point numbers (`3.14`).
  - Recognizes hex colors (`#ff5500`, `#333`) and string literals (`"hello"`).
  - Skips inline and block comments without breaking line counters.
  - Generates `NEWLINE` tokens where syntactically significant and skips redundant empty lines.
  - Returns `EOF` at end of input.
- [ ] Never enters an infinite loop or panics on malformed or unexpected bytes.
- [ ] Table-driven tests covering:
  - All token types and keywords.
  - Unicode characters in comments and strings.
  - Unterminated strings, orphan symbols, and illegal characters.
  - Boundary cases (empty string, whitespace only, Windows `\r\n` vs Unix `\n`).

## 4. Definition of Done (DoD)
- [ ] `internal/language/compile/lexer` package implemented.
- [ ] `lexer_test.go` achieves >90% code coverage.
- [ ] All table-driven tests pass under `go test -v -race ./internal/language/compile/lexer/...`.
