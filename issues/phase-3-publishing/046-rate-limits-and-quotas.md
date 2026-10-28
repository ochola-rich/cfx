# [Phase 3] #046: HTTP Rate Limiting, Request Size Limits & Abuse Prevention

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `security`, `rate-limiting`, `operations`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Public endpoints like `POST /compile` perform parsing and semantic checking on user-submitted text. Without rate limiting and payload size restrictions, an attacker could submit megabyte-sized payloads or flood the compiler endpoint to exhaust CPU and memory resources.

## 2. Objective
Implement token-bucket or sliding-window rate limiting and strict HTTP body size enforcement middleware in Go.

## 3. Acceptance Criteria
- [ ] **Request Body Size Limits**:
  - `POST /compile`: max 64KB (sufficient for thousands of lines of script).
  - `POST /artworks`, `PUT /artworks/{id}`: max 128KB.
  - Exceeding size limits immediately aborts read with `413 Payload Too Large` without buffering full body into memory.
- [ ] **Rate Limiting**:
  - In-memory rate limiter per IP address (or API token):
    - `POST /compile`: 30 requests per minute per IP (with burst allowance up to 10).
    - `POST /artworks`: 10 requests per minute per IP.
    - `GET /art/{id}.json`: high threshold (e.g. 500 req/min per IP) to accommodate embeds.
  - Returns `429 Too Many Requests` with `Retry-After` header when limit is exceeded.
- [ ] Whitelist configuration support for internal test runners and health checks.

## 4. Definition of Done (DoD)
- [ ] Middleware implemented in `internal/publishing/http/ratelimit.go`.
- [ ] Unit tests verify `413` on oversized body and `429` on excessive request frequency.
