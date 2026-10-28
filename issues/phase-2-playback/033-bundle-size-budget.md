# [Phase 2] #033: Runtime Bundle Size Optimization & Budget Enforcement (<10KB)

**Phase:** Phase 2: Playback context (runtime)  
**Labels:** `phase:2-playback`, `runtime`, `performance`, `bundle-size`  
**Milestone:** Phase 2: Playback context  

---

## 1. Background & Context
A core product promise of `cfx` is that embedding an artwork requires an embed script costing under ~10KB (minified and gzipped/brotli), making it virtually invisible in network waterfalls compared to massive graphics runtimes like p5.js (~800KB) or Three.js (~600KB).

## 2. Objective
Configure the production bundler (Rollup / esbuild) with aggressive tree-shaking, minification, and an automated size-limit check in CI to strictly enforce the `< 10KB` payload budget.

## 3. Acceptance Criteria
- [ ] Build pipeline configured to output:
  - `dist/creative-canvas.min.js` (standalone IIFE/ESM for `<script src="...">` embeds).
- [ ] Bundle includes:
  - Custom element registration
  - Expression evaluator
  - 2D Canvas renderer
  - Input & intersection listeners
- [ ] Uses zero heavy external runtime dependencies (zero npm dependencies in final bundle).
- [ ] Automated size check configured using `size-limit` or custom script:
  - Gzipped bundle size must remain strictly under 10KB.
  - CI fails immediately if a pull request increases bundle size past the 10KB budget limit.

## 4. Definition of Done (DoD)
- [ ] Production build script (`npm run build`) outputs optimized bundle.
- [ ] Size verification script runs in CI workflow and reports bundle size.
- [ ] Current bundle size documented in `runtime/README.md`.
