# [Phase 4] #049: Interactive Preview Canvas with Pan, Zoom & Fit Controls

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `canvas`, `viewport`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
Creators need to inspect their visuals at arbitrary canvas resolutions, test responsiveness, zoom into fine details, or pan across large canvases. The studio preview pane must host the `<creative-canvas>` element wrapped in a versatile viewport controller.

## 2. Objective
Implement the interactive canvas viewport in `studio/src/components/Preview/` supporting smooth panning, mouse-wheel zooming, and quick zoom presets (Fit to Screen, 100%, 200%).

## 3. Acceptance Criteria
- [ ] Viewport container embeds the `<creative-canvas>` web component runtime.
- [ ] Controls toolbar:
  - Zoom in (`+`), Zoom out (`-`), Zoom level badge (`100%`).
  - "Fit to Viewport" button (centers canvas and scales to fit available screen space).
  - "Actual Size" button (1:1 pixel scale).
  - Play / Pause animation toggle.
- [ ] Mouse & touch navigation:
  - Mouse wheel scrolls/zooms anchored to pointer position.
  - Middle-click drag or spacebar + drag pans the canvas viewport.
- [ ] Visual canvas boundaries:
  - Subtle drop shadow and checkered background pattern outside the canvas to distinguish canvas borders from transparent scenes.

## 4. Definition of Done (DoD)
- [ ] Viewport component implemented and tested.
- [ ] User interaction tests verify zoom and pan transformations operate smoothly without stutter.
