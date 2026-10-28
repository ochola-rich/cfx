# [Phase 0] #007: Architecture Decision Records for Strategic DDD Design

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `architecture`, `ddd`, `adr`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
Initial design iterations explored varied paradigms for scripting and rendering. We need authoritative, versioned Architecture Decision Records (ADRs) that formally establish:
1. **Bounded Context Boundaries and Strategic Relationships:** Language (Core), Playback (Core/Conforming), Publishing (Supporting/Customer), and Identity (Generic).
2. **Scene IR as Published Language:** The JSON Scene representation serves as the unbending public contract between the Go compiler and browser JavaScript runtime.
3. **Closed English-like Syntax:** Why a declarative domain-specific English syntax was chosen over Lua, QuickJS, Python, or standard JavaScript.

## 2. Objective
Write and commit three foundational ADRs under `docs/adr/` capturing rationale, alternatives considered, constraints, and long-term consequences.

## 3. Acceptance Criteria
- [ ] `docs/adr/0001-bounded-contexts-and-strategic-design.md` written and committed:
  - Explains the context map (Customer/Supplier with ACL, Published Language).
  - Justifies isolation of the pure Language domain from web/database concerns.
- [ ] `docs/adr/0004-scene-ir-as-published-language.md` written and committed:
  - Details why the Scene intermediate representation is schema-versioned (`"version": 1`).
  - Explains how independent versioning allows compiler evolution without breaking existing embedded scenes.
- [ ] `docs/adr/0005-closed-english-like-language-syntax.md` written and committed:
  - Documents why a closed declarative language prevents security vulnerabilities (no `eval`, no network, no infinite loops).
  - Documents how friendly syntax enables non-programmers to create visuals in <2 minutes.

## 4. Definition of Done (DoD)
- [ ] All 3 ADRs committed in standard format under `docs/adr/`.
- [ ] ADR index committed at `docs/adr/README.md`.
- [ ] Documents cross-referenced in `docs/ddd-design.md`.
