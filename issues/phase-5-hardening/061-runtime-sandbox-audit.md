# [Phase 5] #061: Runtime Sandbox Security Audit (Zero DOM, Network, Storage or eval Leakage)

**Phase:** Phase 5: Hardening  
**Labels:** `phase:5-hardening`, `security`, `sandbox`, `audit`  
**Milestone:** Phase 5: Hardening  

---

## 1. Background & Context
The central security guarantee of `cfx` to site owners is:
> **"Published scenes cannot touch the host page."**
This means the runtime web component and its expression evaluator must be completely incapable of accessing `document.cookie`, querying elements outside its Shadow DOM, sending unauthorized network requests (`fetch`/`XMLHttpRequest`), reading `localStorage`, or executing arbitrary JavaScript via `eval`.

## 2. Objective
Build an automated security isolation test suite and execute a full code audit confirming complete sandbox containment.

## 3. Acceptance Criteria
- [ ] Static code analysis / AST lint rule:
  - Enforces that `runtime/src/` contains zero occurrences of:
    - `eval(`
    - `Function(`
    - `setTimeout(` or `setInterval(` with string arguments
    - `document.cookie`
    - `window.localStorage` or `window.sessionStorage`
    - `fetch(` or `XMLHttpRequest` (outside of the element's dedicated `load(src)` method)
- [ ] Dynamic penetration tests running in headless browser:
  - Injects adversarial Scene IR payloads attempting:
    - Prototype pollution (`__proto__`, `constructor`)
    - Escape from Shadow DOM (`getRootNode()`, `parentNode`)
    - Cookie theft or DOM manipulation
  - Confirms all attack vectors fail and raise zero side-effects on the parent page.

## 4. Definition of Done (DoD)
- [ ] Security test suite committed to `runtime/test/security.spec.ts`.
- [ ] Tests run and pass in continuous integration.
- [ ] Security audit report documented in `docs/security-audit.md`.
