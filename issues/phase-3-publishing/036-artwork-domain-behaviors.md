# [Phase 3] #036: Core Artwork Domain Behaviors (SaveDraft, Publish, Unpublish)

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `ddd`, `domain-logic`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
State transitions on the Artwork aggregate should be expressed through explicit, intention-revealing domain methods rather than generic setters. These operations represent real business workflows: drafting a piece, promoting it to a published version, and revoking public access.

## 2. Objective
Implement the core domain behaviors `SaveDraft`, `Publish`, and `Unpublish` on the `Artwork` aggregate in `internal/publishing/domain/artwork.go`.

## 3. Acceptance Criteria
- [ ] `SaveDraft(newScript string) error`:
  - Updates the draft script and sets `UpdatedAt`.
  - Allowed even if `newScript` does not currently compile (drafting tolerance).
- [ ] `Publish(compiledScene scene.Scene, irVersion int) (*Version, error)`:
  - Takes the current draft script and validated Scene IR.
  - Generates the next sequential version number (`len(Versions) + 1`).
  - Creates an immutable `Version` struct with `VersionNumber`, `Script`, `Scene`, `CreatedAt`.
  - Appends to `Versions` collection.
  - Marks the version as publicly active.
- [ ] `Unpublish(versionNumber int) error`:
  - Finds the specified version and marks its status as unpublished/hidden from public embeds.
  - Preserves historical version record without hard-deleting data.

## 4. Definition of Done (DoD)
- [ ] Methods implemented on `Artwork` aggregate.
- [ ] Unit tests verify state transitions, sequential version numbering, and error handling.
