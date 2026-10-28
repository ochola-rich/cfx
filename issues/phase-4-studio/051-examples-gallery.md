# [Phase 4] #051: Examples Gallery with 1-Line "Hello Visual" Starter

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `onboarding`, `templates`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
To achieve the primary success criterion—"A first visual is on screen within 2 minutes with no programming"—the studio must provide a built-in Examples Gallery. Creators can immediately explore, clone, and remix working scripts rather than facing an intimidating blank slate.

## 2. Objective
Build an interactive modal/sidebar Examples Gallery with curated starter pieces, starting with a working one-line visual.

## 3. Acceptance Criteria
- [ ] Curated starter examples included:
  - **Hello Visual (1 line)**: `circle at 200, 200 radius 80 colored #ff0055`
  - **Dynamic Pulse**: circle with pulsating radius `radius 50 + sin(time * 3) * 20`
  - **Mouse Follower**: shape tracking pointer `at mouse_x, mouse_y`
  - **Generative Grid**: loop drawing colored circles across coordinates
  - **Wavy Lines**: repeat loop generating a sine-wave ribbon
- [ ] Gallery UI:
  - Visual thumbnails showing animated previews of each piece.
  - One-click "Load into Editor" or "Fork Example" action.
  - Warns creator before replacing unsaved work.
- [ ] Fully offline-capable (templates embedded directly in Studio client bundle).

## 4. Definition of Done (DoD)
- [ ] Gallery component implemented in `studio/src/components/Gallery/`.
- [ ] Loading any template immediately renders in preview without errors.
