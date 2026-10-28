# [Phase 2] #024: Scene Walker and requestAnimationFrame Render Loop

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `rendering`, `performance`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
The Playback runtime is responsible for executing the Scene IR in the browser. It must traverse the scene node tree and draw to an HTML5 `<canvas>` on every display refresh using `requestAnimationFrame`, maintaining 60 FPS while minimizing CPU usage and memory allocations.

## 2. Objective
Implement `runtime/src/renderer.ts` with a recursive or iterative Scene walker and a robust `requestAnimationFrame` game/render loop.

## 3. Acceptance Criteria
- [ ] Render loop tracks high-precision timestamp (`performance.now()`) converted to fractional seconds (`time`).
- [ ] Traverses scene root nodes in document order (background -> shapes -> loops) preserving layer order.
- [ ] Uses a single 2D rendering context (`CanvasRenderingContext2D`).
- [ ] Clears canvas before each frame or applies background color cleanly.
- [ ] Loop can be cleanly paused and resumed without time jumps or delta spikes.
- [ ] Maintains a steady 60 frames per second on mid-tier hardware for typical scenes (< 500 nodes).

## 4. Definition of Done (DoD)
- [ ] Renderer loop implemented in `runtime/src/renderer.ts`.
- [ ] Unit tests verify time step progression and frame execution.
- [ ] Verified to run without memory leaks over prolonged execution (no heap growth).
