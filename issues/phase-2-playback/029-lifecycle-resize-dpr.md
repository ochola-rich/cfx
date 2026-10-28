# [Phase 2] #029: Lifecycle Teardown, ResizeObserver & HiDPI DevicePixelRatio Handling

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `hidpi`, `memory-management`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
Two major flaws plague canvas web components:
1. **Blurry graphics on Retina/HiDPI screens** if `devicePixelRatio` is ignored.
2. **Memory leaks and zombie animation loops** when an element is dynamically removed from the DOM (e.g. during client-side SPA route transitions) without canceling `requestAnimationFrame` and detaching event listeners.

## 2. Objective
Implement HiDPI backing-store canvas scaling and robust `disconnectedCallback()` lifecycle teardown in the `<creative-canvas>` element.

## 3. Acceptance Criteria
- [ ] **HiDPI / Retina Scaling**:
  - Internal canvas buffer dimensions set to `width * window.devicePixelRatio` and `height * window.devicePixelRatio`.
  - Display CSS width/height styled to logical CSS dimensions.
  - 2D rendering context automatically scaled via `ctx.scale(dpr, dpr)` so scene drawing logic remains in logical pixels while rendering crisp vectors on all screens.
- [ ] **Dynamic Resizing**:
  - Uses `ResizeObserver` to observe host element dimension changes and redraw without distorting aspect ratios.
- [ ] **Lifecycle Teardown (`disconnectedCallback`)**:
  - Cancels active `requestAnimationFrame` handle immediately.
  - Disconnects `ResizeObserver` and `IntersectionObserver`.
  - Removes all window and document event listeners.
  - Clears cached scene references to allow full garbage collection.

## 4. Definition of Done (DoD)
- [ ] Lifecycle and HiDPI logic verified across simulated DPRs (1x, 2x, 3x).
- [ ] Leak test passes: creating and removing 100 elements sequentially results in zero dangling event listeners or CPU activity.
