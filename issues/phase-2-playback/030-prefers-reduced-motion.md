# [Phase 2] #030: Accessibility: Respect prefers-reduced-motion Preference

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `a11y`, `accessibility`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
Many users experience vestibular disorders, motion sickness, or cognitive distress when exposed to persistent, unprompted animation. Operating systems provide an accessibility preference (`prefers-reduced-motion: reduce`) which web applications are ethically and legally obligated to honor.

## 2. Objective
Incorporate automated detection and graceful motion suppression in the `<creative-canvas>` element when `prefers-reduced-motion` is active.

## 3. Acceptance Criteria
- [ ] Detects user's motion preference using `window.matchMedia('(prefers-reduced-motion: reduce)')`.
- [ ] Listens to dynamic changes on the media query (if user toggles system settings during an active session).
- [ ] **Behavior when reduced motion is requested**:
  - The scene does not run continuous animation loops; instead, it renders a static initial poster frame (e.g., at `time = 0` or `time = 1`).
  - An optional unobtrusive play/pause toggle indicator can be surfaced to allow the user to manually opt-in to motion.
  - Interactive mouse movements can be throttled or simplified.
- [ ] Can be explicitly overridden via HTML attribute if needed (e.g. `<creative-canvas motion="allowed">`).

## 4. Definition of Done (DoD)
- [ ] Media query listener implemented and tested with mock matchMedia events.
- [ ] Verified that animation stops when `prefers-reduced-motion: reduce` matches.
