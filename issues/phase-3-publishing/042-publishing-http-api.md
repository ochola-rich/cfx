# [Phase 3] #042: Publishing REST HTTP API Handlers

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `http`, `api`, `rest`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
The HTTP layer connects client applications (Studio, CLI, public embedders) with the application services. It must adhere strictly to `docs/api-spec.md` with structured JSON errors, accurate HTTP status codes, and clean request decoding.

## 2. Objective
Implement the HTTP routing and handler endpoints in `internal/publishing/http/`:
- `POST /compile`
- `POST /artworks`
- `GET /artworks`
- `GET /artworks/{id}`
- `PUT /artworks/{id}`
- `POST /artworks/{id}/publish`
- `GET /art/{id}.json`
- `GET /embed.js`

## 3. Acceptance Criteria
- [ ] Endpoints implemented per `docs/api-spec.md`:
  - `POST /compile`: Anonymous. Compiles script payload, returns Scene JSON (200) or diagnostics array (400).
  - `POST /artworks`: Creates artwork with initial draft, returns 201 Created and ID.
  - `GET /artworks/{id}`: Returns artwork details and draft (requires authorization).
  - `PUT /artworks/{id}`: Saves draft script.
  - `POST /artworks/{id}/publish`: Compiles and publishes draft as a new version.
  - `GET /art/{id}.json`: Public endpoint returning latest published Scene IR JSON.
  - `GET /embed.js`: Serves the compiled `<creative-canvas>` JavaScript runtime bundle.
- [ ] Standardized JSON error response format:
  `{ "error": { "code": "...", "message": "..." } }`.
- [ ] Request payload size limits enforced (e.g. max 1MB for scripts).

## 4. Definition of Done (DoD)
- [ ] HTTP router and handlers implemented using standard Go `net/http` (or chi/mux).
- [ ] End-to-end integration tests (`httptest.Server`) verify all routes and status codes.
