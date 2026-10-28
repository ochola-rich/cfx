# [Phase 4] #058: Visual Bidirectional Property Inspector (Source Code Mapping)

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `feature`, `sourcemap`, `future`  
**Milestone:** Phase 4: Studio (Optional / Post-v1)  

---

## 1. Background & Context
Once the read-only inspector and AST source coordinates (#011, #013) are in place, a powerful next step is an **editable visual inspector**: dragging a color picker or numeric slider in the UI automatically updates the exact line and column in the source script text, providing bidirectional synchronization between visual editing and code.

## 2. Objective
Prototype bidirectional code synchronization where modifying visual inspector inputs rewrites the corresponding token in the source script using compiler source spans.

## 3. Acceptance Criteria
- [ ] Compiler emits AST node source spans (`[startOffset, endOffset]`) into Scene IR debug metadata.
- [ ] Inspector UI renders interactive inputs for selected shapes:
  - Color picker for `colored` property.
  - Number slider for `radius`, `width`, `height`, `opacity`.
- [ ] Mutating an inspector control:
  - Replaces the exact character slice in the script buffer without reformatting unrelated lines or stripping user comments.
  - Re-triggers debounced compile to update preview.
- [ ] Gracefully disables direct editing for properties governed by dynamic formulas (e.g. `sin(time)` shows formula badge and disables static number slider).

## 4. Definition of Done (DoD)
- [ ] Architecture design and prototype branch validated.
- [ ] Verified that updating a color slider modifies source code accurately without corrupting indentation.
