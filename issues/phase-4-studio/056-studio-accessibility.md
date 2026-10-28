# [Phase 4] #056: Studio Accessibility (a11y) & WCAG AA Compliance

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `a11y`, `compliance`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
The Studio UI must be welcoming and usable for all people, including screen reader users, individuals relying solely on keyboard navigation, and creators with low vision or color blindness.

## 2. Objective
Audit and implement WCAG 2.1 AA accessibility standards across the Studio application.

## 3. Acceptance Criteria
- [ ] **Contrast**: All UI text, icons, and interactive elements meet or exceed WCAG AA contrast ratios (minimum 4.5:1 for normal text, 3:1 for large text and UI components).
- [ ] **Keyboard Navigation**:
  - Logical tab focus order across toolbar, editor, layers, and preview.
  - Visible, high-contrast focus rings on all interactive elements.
  - No keyboard traps.
  - Modals and dialogs trap focus while open and restore focus on close.
- [ ] **Screen Reader Support**:
  - All icon-only buttons include `aria-label` (e.g. `aria-label="Zoom in"`).
  - Diagnostic error banner uses `aria-live="polite"` so newly emitted errors are announced to screen readers without interrupting speech.
  - Canvas element includes descriptive `aria-label` or fallback description.
- [ ] Automated testing using `@axe-core/playwright` or Lighthouse reports zero high-priority a11y violations.

## 4. Definition of Done (DoD)
- [ ] Accessibility pass completed and documented.
- [ ] Lighthouse Accessibility score >= 95.
