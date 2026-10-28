# [Phase 2] #027: Interactive Input Tracking & Canvas Coordinate Normalization

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `input`, `math`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
When embedded, a `<creative-canvas>` may be styled with arbitrary CSS dimensions (e.g. `width: 100%; height: auto;`), scaled via CSS transforms, or zoomed on mobile devices. Raw browser pointer events (`clientX`, `clientY`) must be transformed into internal canvas coordinate space (`mouse_x`, `mouse_y`) so interaction coordinates match the scene's logical canvas dimensions.

## 2. Objective
Implement input tracking and coordinate transformation in `runtime/src/input.ts`.

## 3. Acceptance Criteria
- [ ] Tracks pointer coordinates across mouse and touch interactions:
  - Listens to `pointermove`, `pointerenter`, `pointerleave`, `touchstart`, `touchmove`.
- [ ] Transforms pointer positions using the canvas bounding rectangle (`getBoundingClientRect()`) and current internal canvas scale:
  $$\text{canvas\_x} = (e.\text{clientX} - \text{rect}.\text{left}) \times \left(\frac{\text{canvas}.\text{width}}{\text{rect}.\text{width}}\right)$$
- [ ] Smooth fallback: when the pointer exits the canvas bounds, `mouse_x` and `mouse_y` either retain their last position or park at the canvas center (configurable).
- [ ] High-frequency pointer events throttled or aligned with `requestAnimationFrame` to avoid unnecessary layout thrashing.

## 4. Definition of Done (DoD)
- [ ] Input module implemented in `runtime/src/input.ts`.
- [ ] Unit tests verify coordinate calculation across different CSS sizes, padding, and device pixel ratios.
