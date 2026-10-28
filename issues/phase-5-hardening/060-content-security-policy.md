# [Phase 5] #060: Content Security Policy (CSP) & HTTP Security Headers

**Phase:** Phase 5: Hardening  
**Labels:** `phase:5-hardening`, `security`, `http`, `csp`  
**Milestone:** Phase 5: Hardening  

---

## 1. Background & Context
A strict Content Security Policy (CSP) and HTTP security response headers prevent data exfiltration, clickjacking, MIME-sniffing, and cross-site scripting attacks against the Studio and API endpoints.

## 2. Objective
Configure production-grade CSP headers and security middleware in the Go HTTP daemon (`cmd/cfxd`).

## 3. Acceptance Criteria
- [ ] Strict HTTP headers configured:
  - `Content-Security-Policy`:
    - `default-src 'none';`
    - `script-src 'self' 'wasm-unsafe-eval' https://cfx.dev;` (strictly no `'unsafe-inline'` or `'unsafe-eval'`)
    - `style-src 'self' 'unsafe-inline';`
    - `connect-src 'self' https://api.cfx.dev;`
    - `img-src 'self' data: blob:;`
    - `frame-ancestors 'none';` (blocks iframe embedding of the Studio to prevent clickjacking)
  - `X-Content-Type-Options: nosniff`
  - `X-Frame-Options: DENY`
  - `Referrer-Policy: strict-origin-when-cross-origin`
  - `Permissions-Policy: geolocation=(), camera=(), microphone=()`
- [ ] Specialized headers for `/embed.js` to allow embedding on host sites without polluting the host's policies.
- [ ] Automated security header tests in `internal/publishing/http/security_test.go`.

## 4. Definition of Done (DoD)
- [ ] Security middleware implemented and active on all routes.
- [ ] SecurityHeaders.com / Mozilla Observatory score target of A+.
