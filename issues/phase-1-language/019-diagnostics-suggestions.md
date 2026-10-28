# [Phase 1] #019: Diagnostic Engine with Source Highlighting and Fuzzy Suggestions

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `diagnostics`, `ux`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
For non-programmers, error messages are make-or-break. Cryptic compiler errors (like `unexpected token at byte 42`) lead to immediate abandonment. `cfx` diagnostics must be compassionate, pinpoint exact line and column locations, and offer fuzzy spelling suggestions ("did you mean circle?").

## 2. Objective
Implement `internal/language/compile/diagnostic/diagnostic.go` featuring friendly error formatting, Levenshtein distance-based keyword suggestions, and JSON serialization for UI clients.

## 3. Acceptance Criteria
- [ ] `Diagnostic` struct attributes:
  - `Code`: string error code (e.g. `UNKNOWN_KEYWORD`, `UNMATCHED_REPEAT`, `UNDEFINED_VARIABLE`)
  - `Message`: plain English explanation of the issue
  - `Line`: 1-based line number
  - `Column`: 1-based column number
  - `Length`: length of offending token for editor squiggly underlines
  - `Hint`: actionable suggestion on how to fix it (optional)
- [ ] Fuzzy keyword suggestion engine:
  - If creator types `circl`, engine suggests `"did you mean 'circle'?"`.
  - If creator types `colord`, engine suggests `"did you mean 'colored'?"`.
  - Uses Levenshtein distance with a threshold <= 2 edits.
- [ ] String rendering formats error cleanly for CLI/terminal with source snippet:
  ```
  Error [Line 3, Col 5]: unknown shape 'circl'
      3 | circl at 100, 100
        | ^^^^^ did you mean 'circle'?
  ```

## 4. Definition of Done (DoD)
- [ ] Diagnostic package implemented with unit tests for error formatting and fuzzy suggestions.
- [ ] Zero unformatted or unlocated panic messages escaping to the user.
