# [Phase 3] #044: HTTP Caching Headers, ETags, and Conditional Requests

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `http`, `caching`, `performance`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Public artwork embeds (`GET /art/{id}.json`) and the embed script (`GET /embed.js`) are heavily requested static or semi-static assets. Serving these without proper HTTP cache headers causes redundant server load and slows down host pages. Immutable published versions and immutable release scripts should be aggressively cached by CDNs and browsers.

## 2. Objective
Implement standard HTTP caching headers, cryptographic ETags, and conditional `304 Not Modified` responses across all public static and embed endpoints.

## 3. Acceptance Criteria
- [ ] **Published Scene Endpoints (`/art/{id}.json`)**:
  - Generates deterministic `ETag` based on content hash (SHA-256) of the Scene JSON.
  - Supports `If-None-Match` request header; returns `304 Not Modified` with zero response body when matched.
  - Emits `Cache-Control: public, max-age=300, stale-while-revalidate=86400` for dynamic latest pointers.
  - For immutable versioned endpoints (`/art/{id}/v1.json`): emits `Cache-Control: public, max-age=31536000, immutable`.
- [ ] **Runtime Script (`/embed.js`)**:
  - Emits `Cache-Control: public, max-age=86400, stale-while-revalidate=604800` (or `immutable` if served with version hash in URL).
  - Emits `ETag` matching the bundled runtime release hash.

## 4. Definition of Done (DoD)
- [ ] Caching middleware implemented and applied to public endpoints.
- [ ] Integration tests verify `ETag` generation, `If-None-Match` returning `304`, and correct `Cache-Control` headers.
