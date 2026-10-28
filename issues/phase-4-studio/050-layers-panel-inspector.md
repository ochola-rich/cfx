# [Phase 4] #050: Studio Layers Panel & Read-Only Node Inspector

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `inspector`, `layers`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
Visual creators coming from design tools like Figma or Photoshop expect a layer hierarchy showing what shapes exist and their stacking order. Inspecting a layer should display its computed properties (position, dimensions, color, opacity, formulas) in a clear visual panel.

## 2. Objective
Implement the Studio sidebar containing a hierarchical Layers Tree and a read-only Property Inspector.

## 3. Acceptance Criteria
- [ ] **Layers Tree Panel**:
  - Displays list of scene elements ordered from top layer to bottom layer.
  - Icons identifying node types: circle, rectangle, line, repeat group, background.
  - Displays friendly label for each item (e.g. `Circle (radius 50)`).
  - Hovering a layer in the list highlights the corresponding shape on the preview canvas with an overlay outline.
- [ ] **Read-Only Property Inspector**:
  - Clicking a layer selects it and populates the inspector pane.
  - Displays property fields:
    - Type (`circle`)
    - Position (`x: 200, y: 300` or formula `sin(time)*50`)
    - Dimensions (`radius: 50`)
    - Fill / Stroke / Opacity
  - Read-only in v1 (indicates values are driven by script).

## 4. Definition of Done (DoD)
- [ ] Layers tree and inspector panels implemented in `studio/src/components/Sidebar/`.
- [ ] Component updates synchronously whenever the Scene IR updates.
