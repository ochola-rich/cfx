# [Phase 4] #052: Draft Autosave Mechanism (Local Storage + Backend Sync)

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `persistence`, `autosave`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
Creators must never lose work due to accidental browser tab closure, page reloads, network dropouts, or power loss. The Studio must continuously persist the working draft locally and synchronize with the backend publishing API.

## 2. Objective
Implement automated draft persistence combining immediate browser `localStorage` caching with debounced server `PUT /artworks/{id}` synchronizations.

## 3. Acceptance Criteria
- [ ] **Local Persistence**:
  - Immediately persists script and artwork ID into `localStorage` on every keystroke.
  - On page reload, restores unsaved draft seamlessly.
- [ ] **Remote Server Sync**:
  - Debounced background sync (e.g. 2 seconds of inactivity or blur event) calls `PUT /artworks/{id}`.
  - UI displays subtle save status indicator:
    - `"Saving..."` (spinner)
    - `"Saved to cloud"` (checkmark)
    - `"Saved locally (offline)"` (cloud-slash icon)
- [ ] Conflict resolution:
  - If another session modified the artwork, detects revision mismatch (ETag / revision number) and prompts the user before overwriting.

## 4. Definition of Done (DoD)
- [ ] Autosave hook implemented in `studio/src/hooks/useAutosave.ts`.
- [ ] Tests verify draft restoration after simulated browser crash or disconnect.
