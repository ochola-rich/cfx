# [Phase 0] #001: Agree and Finalize the Core Problem Statement

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `documentation`, `product`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
Creators without software engineering experience are locked out of producing generative, interactive visuals for websites. The current landscape is polarized:
1. **Developer-only code libraries** (p5.js, Three.js, raw Canvas/WebGL, GLSL shaders) require programming knowledge, build pipelines, and complex script embedding.
2. **Static no-code tools** (Lottie animations, GIF/WebP, Webflow interactions) only replay pre-computed keyframes and cannot react dynamically to real-time variables like time or mouse coordinates.
3. **Security and performance risks**: site owners are hesitant to inject arbitrary 3rd-party `<script>` tags that have unrestricted DOM and network access or bloat pages by 200KB+.

`cfx` bridges this gap with an English-like domain-specific visual language compiled into an intermediate JSON representation (Scene IR) and rendered via a sandboxed, lightweight (<10KB) web component.

## 2. Objective
Validate, refine, and formally sign off on the problem statement in `docs/problem-statement.md` with explicit non-goals and target success metrics.

## 3. Acceptance Criteria
- [ ] Core problem statement clearly defines the three distinct personas: Creators, Site Owners/Embedders, and End Visitors.
- [ ] Explicit distinction between static animation replays (Lottie) and interactive/generative canvas capabilities is articulated.
- [ ] Measurable success criteria are established:
  - First visual render in < 2 minutes for a non-programmer.
  - Embed runtime payload < 10KB gzipped.
  - Complete host isolation (zero DOM/network/cookie access from scene runtime).
- [ ] Explicit non-goals for v1 are locked down (no 3D/WebGL, no general-purpose Turing-complete programming, no video export, no real-time multi-user collaboration).
- [ ] Stakeholder sign-off or recorded consensus documented in the file header.

## 4. Definition of Done (DoD)
- [ ] `docs/problem-statement.md` is reviewed, updated, and committed to main.
- [ ] README.md links to the finalized problem statement.
- [ ] No ambiguous or placeholder text remains in the document.
