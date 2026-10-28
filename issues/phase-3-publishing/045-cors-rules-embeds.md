# [Phase 3] #045: Cross-Origin Resource Sharing (CORS) Configuration for Embeds

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `security`, `http`, `cors`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Public visual embeds (`<creative-canvas src="...">`) will be loaded by third-party websites across the entire internet. If CORS headers are missing or restrictive on `GET /art/{id}.json`, the browser `fetch()` call inside the web component will be blocked by the Same-Origin Policy. Conversely, authoring APIs (`PUT /artworks/{id}`) must NOT allow arbitrary origin access.

## 2. Objective
Configure distinct, granular CORS middleware rules for public embed endpoints versus private management/studio endpoints.

## 3. Acceptance Criteria
- [ ] **Public Embed Endpoints (`/art/*.json`, `/embed.js`, `/compile`)**:
  - `Access-Control-Allow-Origin: *`
  - `Access-Control-Allow-Methods: GET, POST, OPTIONS`
  - `Access-Control-Allow-Headers: Content-Type, If-None-Match`
  - `Access-Control-Max-Age: 86400`
  - Pre-flight `OPTIONS` requests handled immediately with `204 No Content`.
- [ ] **Private Management Endpoints (`/artworks`, `/artworks/*`)**:
  - Restricts origins to trusted studio origins (e.g. `https://cfx.dev`, `http://localhost:5173` in development).
  - Requires credentials/bearer tokens.
- [ ] Automated tests verify headers for both preflight and actual requests from various origins.

## 4. Definition of Done (DoD)
- [ ] CORS middleware implemented in `internal/publishing/http/cors.go`.
- [ ] Test suite verifies public endpoints allow wildcard origins while management endpoints restrict unauthorized origins.
