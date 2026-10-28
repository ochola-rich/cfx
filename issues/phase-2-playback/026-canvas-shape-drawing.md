# [Phase 2] #026: Canvas 2D Shape Renderers (Circle, Rectangle, Line, Background)

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `rendering`, `canvas`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
The Playback runtime must map Scene IR primitives to native HTML5 Canvas 2D drawing calls, properly managing transformation matrices, styling state, alpha transparency/opacity, and path closures.

## 2. Objective
Implement shape rendering routines in `runtime/src/shapes/` for `circle`, `rectangle`, `line`, and `background`.

## 3. Acceptance Criteria
- [ ] Shape rendering implementations:
  - **Background**: full-canvas color fill with optional opacity.
  - **Circle**: arc path centered at `(x, y)` with radius `r`, fill color, stroke color, stroke width, and opacity.
  - **Rectangle**: rectangle at `(x, y)` with width `w` and height `h`, fill color, stroke, and opacity.
  - **Line**: segment from `(x1, y1)` to `(x2, y2)` with line stroke color, thickness, and cap style.
- [ ] Context state management:
  - Preserves canvas state using `ctx.save()` / `ctx.restore()` so transformations (e.g. rotation, globalAlpha) do not bleed between sibling shapes.
- [ ] Color normalization:
  - Handles hex (`#fff`, `#112233`), named colors (`red`, `papayawhip`), and rgb/hsl strings.
- [ ] Visual verification tests (using `canvas` mock in Node/Vitest) confirm exact draw calls.

## 4. Definition of Done (DoD)
- [ ] Shape renderers implemented and tested.
- [ ] Visual snapshot or draw op assertions pass for each supported shape type.
