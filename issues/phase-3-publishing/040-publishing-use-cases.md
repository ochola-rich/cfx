# [Phase 3] #040: Application Use Cases (CreateArtwork, SaveDraft, PublishArtwork)

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `clean-architecture`, `use-cases`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Application services coordinate domain logic, repository queries, and ports to execute real user use cases. These use cases form the boundary invoked by HTTP handlers or CLI commands.

## 2. Objective
Implement the primary application commands and handlers in `internal/publishing/app/`:
1. `CreateArtwork`
2. `SaveDraft`
3. `PublishArtwork`

## 3. Acceptance Criteria
- [ ] **CreateArtworkHandler**:
  - Validates title and creator credentials.
  - Instantiates a new `Artwork` aggregate with optional initial starter script.
  - Saves to `ArtworkRepository`.
  - Returns newly created Artwork ID and metadata.
- [ ] **SaveDraftHandler**:
  - Retrieves `Artwork` by ID.
  - Verifies ownership / bearer token.
  - Executes `artwork.SaveDraft(script)`.
  - Persists changes in repository.
- [ ] **PublishArtworkHandler**:
  - Retrieves `Artwork` by ID and validates ownership.
  - Invokes `SceneCompiler.Compile(script)` via the ACL port.
  - If compilation fails, returns validation errors and aborts publish.
  - If compilation succeeds, calls `artwork.Publish(scene, irVersion)`.
  - Persists updated aggregate and publishes domain events.
  - Returns published version number and public embed URL.

## 4. Definition of Done (DoD)
- [ ] Application services implemented in `internal/publishing/app/`.
- [ ] Comprehensive unit tests using mock repositories and mock compilers.
