# [Phase 1] #009: Formal EBNF Grammar for the Visual Language

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `compiler`, `spec`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The visual language of `cfx` is designed for creators who are not programmers. It reads like natural English instructions while strictly maintaining an unambiguous, LL(1) or LR compatible formal grammar that can be parsed deterministically without backtracking or ambiguities.

## 2. Objective
Formalize the complete EBNF (Extended Backus-Naur Form) grammar for the visual language and document it in `docs/language-grammar.md`.

## 3. Acceptance Criteria
- [ ] Complete EBNF specification covers all top-level statements:
  - `canvas <width> by <height>`
  - `background <color>`
  - Shape declarations: `circle`, `rectangle`, `line`, `polygon`
  - Property clauses: `at <x>, <y>`, `sized <w> by <h>`, `radius <r>`, `colored <color>`, `opacity <num>`, `rotated <angle>`
  - Repetition loops: `repeat <count> times ... end`
  - Variable assignments: `set <name> to <expr>`
- [ ] Continuation lines formally defined (clauses starting with prepositions `at`, `with`, `colored`, `sized` can continue on newlines).
- [ ] Expression grammar defined with explicit operator precedence (parentheses, multiplication/division, addition/subtraction, trigonometric functions `sin`, `cos`).
- [ ] Built-in identifier keywords specified (`time`, `width`, `height`, `mouse_x`, `mouse_y`, `index`).
- [ ] Grammar verified to be free of left-recursion and shift/reduce conflicts.

## 4. Definition of Done (DoD)
- [ ] `docs/language-grammar.md` updated with finalized EBNF and example scripts.
- [ ] Syntax examples provided for every supported statement form.
