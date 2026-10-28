# [Phase 4] #055: Global Keyboard Shortcuts & Command Palette

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `accessibility`, `shortcuts`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
Power users and keyboard-first creators expect standard accelerator shortcuts to manipulate the editor, run compilation, toggle previews, and trigger publishing without constantly reaching for the mouse.

## 2. Objective
Implement a centralized keyboard shortcut manager and "Shortcuts Help" dialog in `studio/src/components/Shortcuts/`.

## 3. Acceptance Criteria
- [ ] Keyboard shortcut mappings:
  - `Cmd+S` / `Ctrl+S`: Force save draft immediately (prevents default browser "Save Page As").
  - `Cmd+Enter` / `Ctrl+Enter`: Trigger manual compile & canvas refresh.
  - `Cmd+P` / `Ctrl+P`: Open Publish modal.
  - `Space` (when preview focused): Toggle Play/Pause animation loop.
  - `Cmd+0` / `Ctrl+0`: Reset preview zoom to 100% / Fit.
  - `?`: Open keyboard shortcuts cheat sheet dialog.
- [ ] Context awareness: typing in the editor does not inadvertently trigger global non-text navigation keys.
- [ ] Cross-platform handling (Mac `Cmd` vs Windows/Linux `Ctrl`).

## 4. Definition of Done (DoD)
- [ ] Shortcut listener service implemented in `studio/src/services/shortcuts.ts`.
- [ ] Shortcuts cheat sheet modal accessible via UI button and `?` key.
