# [Phase 2] #028: <creative-canvas> Custom Element Web Component

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `web-component`, `api`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
To make embedding effortless for creators and site builders without requiring JavaScript frameworks, `cfx` provides a native Web Component (`customElements.define('creative-canvas', CreativeCanvasElement)`). Site owners can embed any artwork with one standard HTML tag:
`<creative-canvas src="https://cfx.dev/art/abc123.json"></creative-canvas>`

## 2. Objective
Implement `runtime/src/element.ts` defining the `<creative-canvas>` custom element with standard reactive attributes and programmatic control methods.

## 3. Acceptance Criteria
- [ ] Registered custom element tag name: `<creative-canvas>`.
- [ ] Observed attributes:
  - `src`: URL to the Scene IR JSON document. Updating `src` automatically triggers fetch and reload.
  - `paused`: boolean attribute (`paused` or missing). Toggling pauses/resumes the animation loop.
- [ ] Programmatic public methods:
  - `load(srcOrScene: string | Scene): Promise<void>`
  - `pause(): void`
  - `resume(): void`
  - `reset(): void`
- [ ] Encapsulation: uses Shadow DOM (`mode: 'open'`) containing an internal `<canvas>` and default fallback styling (`:host { display: inline-block; overflow: hidden; }`).
- [ ] Network error and loading states handled cleanly without uncaught promise rejections.

## 4. Definition of Done (DoD)
- [ ] Custom element implemented and bundled.
- [ ] Component passes end-to-end browser tests (Playwright or Vitest with Happy-DOM/JSDOM).
