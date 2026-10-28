# [Phase 3] #037: Domain Event Dispatching (DraftSaved, VersionPublished, VersionUnpublished)

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `ddd`, `domain-events`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
When state transitions occur within the Publishing domain, other subsystems (such as the read model projector, cache invalidators, analytics, or activity feeds) need to react asynchronously without creating tight coupling inside the Aggregate. Domain events represent facts that have occurred in the domain.

## 2. Objective
Implement domain event structures and an in-memory event publisher in `internal/publishing/domain/events.go`.

## 3. Acceptance Criteria
- [ ] Domain event types defined:
  - `ArtworkCreated`: `ArtworkID`, `OwnerID`, `Title`, `OccurredAt`
  - `DraftSaved`: `ArtworkID`, `Revision`, `ScriptLength`, `OccurredAt`
  - `VersionPublished`: `ArtworkID`, `VersionNumber`, `SceneJSON`, `IRVersion`, `OccurredAt`
  - `VersionUnpublished`: `ArtworkID`, `VersionNumber`, `OccurredAt`
- [ ] Aggregate tracks uncommitted domain events:
  - `artwork.Events() []DomainEvent`
  - `artwork.ClearEvents()`
- [ ] In-memory event dispatcher or subscriber interface:
  - Supports registering event handlers (e.g. read model updater).
  - Fires events reliably upon successful repository persistence.

## 4. Definition of Done (DoD)
- [ ] Events defined and integrated with aggregate methods.
- [ ] Unit tests verify that calling `Publish()` records a `VersionPublished` event with accurate payload.
