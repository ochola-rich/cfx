# [Phase 1] #022: Continuous Fuzz Testing for Lexer & Parser (Zero Panics Guarantee)

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `security`, `fuzzing`, `testing`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The compiler must safely ingest untrusted, arbitrary user input sent over the web via `POST /compile`. Under no circumstances may arbitrary bytes, null bytes, recursive inputs, or unicode mutations cause a Go panic, hang in an infinite loop, or consume unbounded memory.

## 2. Objective
Implement continuous Go native fuzz testing (`testing.F`) targeting the Lexer, Parser, and Compiler pipeline.

## 3. Acceptance Criteria
- [ ] Native Go fuzz tests implemented:
  - `FuzzLexer(f *testing.F)`: feeds random byte slices to `lexer.New(data).NextToken()` until EOF.
  - `FuzzParser(f *testing.F)`: feeds random string data to `parser.Parse(data)`.
  - `FuzzCompile(f *testing.F)`: feeds arbitrary string inputs into full `language.Compile(data)`.
- [ ] Invariant checks:
  - Execution must NEVER panic. Any panic is treated as a critical security bug.
  - Execution must always terminate within a finite timeout (< 100ms per input).
  - Diagnostics returned must always contain valid, non-negative line and column coordinates.
- [ ] Initial corpus seeded from all golden test scripts.
- [ ] GitHub Actions job or Makefile target configured to run fuzzing for at least 1 minute or on a schedule.

## 4. Definition of Done (DoD)
- [ ] Fuzz test targets implemented and committed.
- [ ] Fuzzing runs locally for at least 100,000 iterations without discovering crashes.
