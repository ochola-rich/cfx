# [Phase 2] #034: Graceful Handling & Error States for Unknown Scene IR Versions

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `resilience`, `versioning`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
Over time, the Scene IR will evolve (e.g. adding 3D, particle systems, or new shape types in a future version 2). If an older runtime encounters a newer Scene version (`"version": 2`), or a corrupted JSON payload, it must never throw unhandled uncaught exceptions that pollute the host page's console or break the host page's scripts.

## 2. Objective
Implement defensive version negotiation, graceful schema validation, and fallback rendering in `runtime/src/scene.ts`.

## 3. Acceptance Criteria
- [ ] Runtime inspects the `"version"` property of incoming Scene JSON:
  - If `version === 1`: loads and executes normally.
  - If `version > 1` (newer than supported): logs a polite warning and displays a lightweight, styled fallback in the canvas:
    - `"This artwork was created with a newer version of cfx. Please update the embed runtime."`
- [ ] If JSON is malformed or schema fails basic invariant checks:
  - Renders a subtle fallback placeholder or error state within the element's Shadow DOM without throwing fatal global errors.
- [ ] Emits custom DOM events on the `<creative-canvas>` element:
  - `cfx-error`: bubbles event containing details of the version mismatch or load failure for host page developers.
  - `cfx-ready`: fires when scene successfully loads and starts rendering.

## 4. Definition of Done (DoD)
- [ ] Graceful fallback routines implemented and unit-tested with newer and invalid version payloads.
- [ ] Zero unhandled errors logged to global `window.onerror`.
