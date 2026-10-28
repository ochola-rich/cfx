# [Phase 3] #035: Artwork Aggregate Root & Domain Invariants

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `ddd`, `domain-model`, `aggregate`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
In Domain-Driven Design, the `Artwork` entity is the Aggregate Root controlling all state modifications, ensuring that business rules and consistency boundaries are never violated. 
Key invariants must hold true at all times:
1. An Artwork must always have a non-empty title.
2. Version numbers must be monotonically increasing positive integers (1, 2, 3...) with no gaps.
3. Once published, a Version snapshot (script + Scene IR) is permanently immutable.
4. Only the owner/creator may modify drafts or publish new versions.

## 2. Objective
Implement the `Artwork` aggregate root and its entity invariants in `internal/publishing/domain/artwork.go`.

## 3. Acceptance Criteria
- [ ] `Artwork` struct defined with private fields and accessor methods:
  - `ID`: unique identifier (UUID v4 or nanoid / ksuid)
  - `Title`: non-empty string (trimmed, max 100 characters)
  - `OwnerID`: creator identifier or secret hash
  - `Draft`: working script string (allowed to contain draft/uncompilable text)
  - `Versions`: slice of published `Version` entities
  - `CreatedAt`, `UpdatedAt`: UTC timestamps
- [ ] Invariants enforced by constructors and mutating methods:
  - Attempting to instantiate an Artwork with an empty title returns a domain error (`ErrEmptyTitle`).
  - Cannot publish with an empty script or missing Scene IR.
  - Published versions are sealed; attempting to alter an existing version raises an error.
  - Mutating methods enforce ownership verification against the caller's identity.

## 4. Definition of Done (DoD)
- [ ] Aggregate implemented in `internal/publishing/domain/artwork.go`.
- [ ] Unit tests thoroughly exercise all invariant protections and edge conditions.
