# [Phase 4] #053: One-Click Publish Workflow & Instant Embed Snippet Generator

**Phase:** Phase 4: Studio (client)  
**Labels:** `phase:4-studio`, `ui`, `publishing`, `embed`  
**Milestone:** Phase 4: Studio  

---

## 1. Background & Context
The culmination of a creator's session is publishing their visual and getting an embed snippet to drop into their website, blog, Webflow, or Notion page. The transition from "Idea to Live Embed" must be seamless, instant, and frictionless.

## 2. Objective
Implement the Studio header "Publish" button and a modal dialog generating copy-ready HTML embed snippets and standalone preview links.

## 3. Acceptance Criteria
- [ ] Primary action "Publish" button in Studio header:
  - Disabled if script has compiler errors; tooltip explains fix needed.
  - Clicking triggers `POST /artworks/{id}/publish`.
- [ ] Post-publish confirmation modal:
  - Generates ready-to-use HTML embed code:
    ```html
    <script type="module" src="https://cfx.dev/embed.js"></script>
    <creative-canvas src="https://cfx.dev/art/abc123.json"></creative-canvas>
    ```
  - "Copy Code" button with instant clipboard feedback (`"Copied!"`).
  - Standalone view URL (`https://cfx.dev/art/abc123`).
  - QR code for quick preview on mobile phones.
  - If using anonymous secret links: clearly displays private edit link and prompts creator to bookmark or save it.

## 4. Definition of Done (DoD)
- [ ] Publish modal and clipboard interactions implemented in `studio/src/components/PublishModal/`.
- [ ] End-to-end test confirms clicking publish creates version and copies snippet to clipboard.
