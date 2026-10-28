# [Phase 0] #004: Event Storming: Domain Events, Commands, Aggregates, and Policies

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `ddd`, `architecture`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
Applying Domain-Driven Design (DDD) requires clear boundaries, commands, events, and business policies across the lifecycle of creative visual assets. Rather than treating artworks as dumb CRUD database rows, state transitions must be captured as discrete domain commands and resulting immutable domain events.

## 2. Objective
Execute an Event Storming modeling exercise covering the end-to-end lifecycle of an Artwork and capture all Commands, Domain Events, Aggregates, Read Models, and Policies into `docs/event-storming.md`.

## 3. Acceptance Criteria
- [ ] Catalog of **Domain Events** (past tense) documented:
  - `ArtworkCreated`
  - `DraftSaved`
  - `DraftReset`
  - `CompilationSucceeded`
  - `CompilationFailed`
  - `VersionPublished`
  - `VersionUnpublished`
  - `ArtworkArchived` / `ArtworkDeleted`
- [ ] Catalog of **Commands** (imperative) documented:
  - `CreateArtwork(title, initialScript, creatorId)`
  - `SaveDraft(artworkId, script, expectedRevision)`
  - `PublishArtwork(artworkId, title, compiledScene, irVersion)`
  - `UnpublishArtwork(artworkId, versionNumber)`
- [ ] Identification of **Aggregates & Invariants**:
  - `Artwork` Aggregate Root: version numbers must be strictly sequential (v1, v2...), published versions are immutable, drafts can be in an uncompilable state while published versions must be valid.
- [ ] **Policies / Event Listeners**:
  - Policy: "When `VersionPublished` occurs -> invalidate edge cache / update read model for `/art/{id}.json`".
  - Policy: "When `VersionPublished` occurs -> trigger embed asset bundle validation".
- [ ] Sequence flows / timeline diagram included (using Mermaid).

## 4. Definition of Done (DoD)
- [ ] `docs/event-storming.md` committed with full diagram and tabular specifications.
- [ ] Aligned with definitions in `docs/ddd-design.md`.
