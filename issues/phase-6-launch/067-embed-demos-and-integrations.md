# [Phase 6] #067: Live Embed Demonstrations (Plain HTML & Site Builders)

**Phase:** Phase 6: Launch  
**Labels:** `phase:6-launch`, `demos`, `showcase`, `qa`  
**Milestone:** Phase 6: Launch  

---

## 1. Background & Context
Before public release, we must validate that embedding actually works in diverse real-world hosting environments and website builders without conflicting with external CSS resets, theme scripts, or security policies.

## 2. Objective
Build and deploy live demonstration pages verifying embeds across standard static HTML and at least two major site builders (Webflow, WordPress, Framer, or Notion).

## 3. Acceptance Criteria
- [ ] **Plain Static HTML Demo**:
  - Standalone HTML page (`examples/demo-embed.html`) running minimal `<creative-canvas>` embed.
  - Verifies zero styling conflicts with CSS resets like Normalize or Tailwind.
- [ ] **CMS / No-Code Site Builder Validation**:
  - Working live demo on Webflow (using an Embed Component).
  - Working live demo on WordPress or Framer.
  - Verified responsive resizing, mobile touch interaction, and viewport offscreen pause.
- [ ] Video recordings or public links captured and added to documentation.

## 4. Definition of Done (DoD)
- [ ] `examples/demo-embed.html` committed to repository.
- [ ] Cross-browser verification (Chrome, Firefox, Safari, Mobile Safari) completed and signed off.
