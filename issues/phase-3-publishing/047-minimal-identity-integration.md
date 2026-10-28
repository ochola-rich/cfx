# [Phase 3] #047: Minimal Identity Context Integration (v1 Auth & Authorization)

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `identity`, `auth`, `security`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Per the architectural decision finalized in Phase 0 (#002), v1 implements a minimal, low-friction identity mechanism. 
Whether using anonymous secret edit tokens (`cfx_sk_...`) or lightweight magic-link / OAuth bearer tokens, the Publishing HTTP layer must enforce authorization checks on all mutating artwork routes.

## 2. Objective
Implement the minimal identity middleware and token verification logic in `internal/identity/` and integrate it with `internal/publishing/http/`.

## 3. Acceptance Criteria
- [ ] Token generation & verification:
  - Generates cryptographically secure high-entropy tokens (e.g. 32-byte URL-safe base64 tokens).
  - Hashes tokens in storage (SHA-256) so database breaches do not compromise edit credentials.
- [ ] Authentication middleware:
  - Extracts credentials from `Authorization: Bearer <token>` header or `?secret=<token>` query param.
  - Injects authenticated `CreatorIdentity` into request `context.Context`.
- [ ] Authorization checks:
  - `POST /artworks`: allows unauthenticated or authenticated creation, returns artwork ID and generated edit secret.
  - `PUT /artworks/{id}` and `POST /artworks/{id}/publish`: verifies token matches the stored owner hash for `id`; returns `401 Unauthorized` if missing, or `403 Forbidden` if mismatched.
  - Public endpoints (`GET /art/{id}.json`) bypass identity checks entirely.

## 4. Definition of Done (DoD)
- [ ] Identity package and authentication middleware implemented.
- [ ] Integration tests verify unauthorized modification attempts are rejected with 401/403.
