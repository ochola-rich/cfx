# [Phase 2] #025: Sandboxed AST Formula Evaluator (Strictly No eval / new Function)

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `security`, `evaluator`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
Dynamic properties in the Scene IR (such as `x = sin(time) * 100`) are delivered as AST expression trees. To guarantee that published visual scenes can never perform Cross-Site Scripting (XSS), touch the host page's DOM, cookies, `window`, or network, the runtime must evaluate formulas using a pure, interpreted tree-walk without using `eval()`, `new Function()`, or `setTimeout("string")`.

## 2. Objective
Implement `runtime/src/evaluator.ts` to evaluate arithmetic and trigonometric expressions in an isolated scope containing only standard runtime variables (`time`, `width`, `height`, `mouse_x`, `mouse_y`, and loop counters).

## 3. Acceptance Criteria
- [ ] Tree-walking evaluator handles:
  - Numeric, boolean, and color constants.
  - Operators: `+`, `-`, `*`, `/`, `%`.
  - Math functions: `Math.sin`, `Math.cos`, `Math.tan`, `Math.min`, `Math.max`, `Math.abs`, `Math.sqrt`, `Math.floor`, `Math.ceil`.
  - Scope lookups: `time`, `width`, `height`, `mouse_x`, `mouse_y`, and scoped variables (e.g. `i`).
- [ ] Safe division: division by zero returns `0` or gracefully falls back instead of throwing or producing `NaN`/`Infinity` that corrupts canvas rendering.
- [ ] **Strict Security Invariant**:
  - The runtime codebase contains zero occurrences of `eval` or `new Function`.
  - Evaluator cannot access `window`, `document`, `globalThis`, `fetch`, `localStorage`, or prototypes.
- [ ] High performance: evaluates >100,000 node expressions per second in micro-benchmarks.

## 4. Definition of Done (DoD)
- [ ] `runtime/src/evaluator.ts` implemented and covered by unit tests.
- [ ] Automated security test asserts that accessing forbidden globals (`window`, `document`, etc.) fails or is impossible.
