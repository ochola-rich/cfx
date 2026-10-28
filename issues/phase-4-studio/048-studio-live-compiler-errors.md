# [Phase 4] #048: Studio Code Editor with Live Compilation & Inline Diagnostics

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `editor`, `compiler-integration`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
The Studio editor is the primary workspace for creators. Non-programmers need instantaneous visual feedback as they type. The editor must integrate live debounced compilation, syntax highlighting, and inline line-anchored diagnostic badges/underlines with fuzzy suggestions directly next to the code.

## 2. Objective
Build the code editor component in `studio/src/components/Editor/` integrating Monaco, CodeMirror 6, or a lightweight custom textarea with syntax styling and inline diagnostics.

## 3. Acceptance Criteria
- [ ] Real-time debounced compilation (e.g. 150-250ms debounce upon keystroke).
- [ ] Submits script to `POST /compile` (or local WebAssembly Go compiler if available).
- [ ] Line-anchored error indicators:
  - Red squiggly underline on offending tokens.
  - Line margin gutter markers (warning/error icons).
  - Hover tooltip displaying the friendly error message and actionable hint (e.g. `"Unknown shape 'circl'. Did you mean 'circle'?"`).
- [ ] Syntax highlighting for keywords (`canvas`, `circle`, `repeat`, `set`), properties (`at`, `radius`, `colored`), numbers, and colors.
- [ ] Resilient typing experience: does not flicker or discard cursor position while live compilation is active.

## 4. Definition of Done (DoD)
- [ ] Editor component integrated in Studio web application.
- [ ] End-to-end test confirms typing invalid code displays inline diagnostic within 300ms.
