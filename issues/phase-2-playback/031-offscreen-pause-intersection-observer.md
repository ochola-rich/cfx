# [Phase 2] #031: Viewport Optimization: Auto-Pause Off-Screen via IntersectionObserver

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `performance`, `battery`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
When visual components are embedded in long blog posts, landing pages, or documentation sites, continuing to run a 60 FPS animation loop while the canvas is scrolled out of the visible viewport drains user laptop and mobile device battery, consumes unnecessary GPU cycles, and contributes to tab lag.

## 2. Objective
Implement automatic loop pausing and resuming using browser `IntersectionObserver` when the `<creative-canvas>` leaves or enters the viewport.

## 3. Acceptance Criteria
- [ ] Connects an `IntersectionObserver` on element attachment (`connectedCallback`).
- [ ] When intersection ratio is `0` (or element is completely outside viewport):
  - Suspends `requestAnimationFrame` loop.
  - Freezes `time` counter so animation doesn't skip forward upon re-entry.
- [ ] When element re-enters the viewport (intersection ratio > 0):
  - Seamlessly resumes `requestAnimationFrame` loop.
  - Offsets internal timestamp so motion continues smoothly without sudden visual jumps.
- [ ] Observer is cleanly disconnected in `disconnectedCallback()`.
- [ ] Provides fallback behavior if `IntersectionObserver` is unavailable (e.g. older legacy browsers).

## 4. Definition of Done (DoD)
- [ ] Intersection observer implemented in `runtime/src/viewport.ts`.
- [ ] Automated tests simulate scrolling element in and out of view, confirming render loop pause/resume transitions.
