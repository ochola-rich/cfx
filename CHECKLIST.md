# cfx Build Checklist

Track progress across the 7 phases of `cfx`. Each phase is designed to be shipped, tested, and validated on its own.

---

## Phase 0: Foundations
- [ ] [#001](issues/phase-0-foundations/001-problem-statement.md) Problem statement agreed and written down
- [ ] [#002](issues/phase-0-foundations/002-v1-identity-decision.md) Decide v1 identity: sign-in vs. anonymous with a secret edit link
- [ ] [#003](issues/phase-0-foundations/003-storage-and-hosting-model.md) Decide storage (SQLite to start?) and hosting model (hosted, self-hostable, or both)
- [ ] [#004](issues/phase-0-foundations/004-domain-event-storming.md) Event storming session: list domain events, commands and policies
- [ ] [#005](issues/phase-0-foundations/005-ubiquitous-language-glossary.md) Ubiquitous language glossary committed to the repo
- [ ] [#006](issues/phase-0-foundations/006-repository-layout-and-modules.md) New repo with the module layout (`cmd/`, `internal/language`, `internal/publishing`, `runtime/`)
- [ ] [#007](issues/phase-0-foundations/007-adrs-ddd-design.md) ADRs rewritten for the DDD design (contexts, Scene as Published Language, English-like syntax)
- [ ] [#008](issues/phase-0-foundations/008-ci-pipeline.md) CI running `go vet`, `gofmt` and tests on every push

---

## Phase 1: Language context (core)
- [ ] [#009](issues/phase-1-language/009-ebnf-formal-grammar.md) Formal grammar (EBNF) for the English-like language
- [ ] [#010](issues/phase-1-language/010-scene-schema-v1.md) Scene schema v1 written down and versioned (`"version": 1`)
- [ ] [#011](issues/phase-1-language/011-tokens-and-positions.md) Tokens with line and column positions
- [ ] [#012](issues/phase-1-language/012-lexer-table-driven-tests.md) Lexer, with table-driven tests
- [ ] [#013](issues/phase-1-language/013-ast-node-types.md) AST node types
- [ ] [#014](issues/phase-1-language/014-statement-parser.md) Parser for statements: `canvas`, `background`, `circle`, `rectangle`, `line`, `repeat ... end`
- [ ] [#015](issues/phase-1-language/015-continuation-lines.md) Continuation lines (`at`, `with`, `colored`... start a new line)
- [ ] [#016](issues/phase-1-language/016-pratt-parser-formulas.md) Pratt parser for formulas, with no `eval` anywhere
- [ ] [#017](issues/phase-1-language/017-semantic-checker.md) Checker: names, loop scopes, reserved words, friendly names (`time`, `width`, `mouse_x`...)
- [ ] [#018](issues/phase-1-language/018-scene-resource-limits.md) Limits enforced in `NewScene`: canvas size, loop iterations, node count, nesting depth
- [ ] [#019](issues/phase-1-language/019-diagnostics-suggestions.md) Diagnostics with line, column, message and a suggestion ("did you mean circle?")
- [ ] [#020](issues/phase-1-language/020-scene-emitter.md) Emitter: AST to Scene
- [ ] [#021](issues/phase-1-language/021-golden-tests.md) Golden tests: script in, scene JSON out, error cases included
- [ ] [#022](issues/phase-1-language/022-fuzz-testing.md) Fuzz test on the lexer and parser (must never panic)
- [ ] [#023](issues/phase-1-language/023-public-compiler-api.md) Public API: `Compile(Script) (Scene, []Diagnostic)`

---

## Phase 2: Playback context (runtime)
- [ ] [#024](issues/phase-2-playback/024-scene-walker-render-loop.md) Scene walker and render loop with `requestAnimationFrame`
- [ ] [#025](issues/phase-2-playback/025-safe-formula-evaluator.md) Safe formula evaluator over the scene's expression tree (no `new Function`)
- [ ] [#026](issues/phase-2-playback/026-canvas-shape-drawing.md) All shapes drawn: circle, rectangle, line, background (with opacity)
- [ ] [#027](issues/phase-2-playback/027-input-handling-scaling.md) Mouse and time inputs, scaled correctly for zoom and CSS size
- [ ] [#028](issues/phase-2-playback/028-creative-canvas-web-component.md) `<creative-canvas>` web component: `src`, `paused`, `load()`, `pause()`, `resume()`
- [ ] [#029](issues/phase-2-playback/029-lifecycle-resize-dpr.md) Cleanup on removal; resizing and device pixel ratio handled
- [ ] [#030](issues/phase-2-playback/030-prefers-reduced-motion.md) Respects `prefers-reduced-motion`
- [ ] [#031](issues/phase-2-playback/031-offscreen-pause-intersection-observer.md) Pauses when off-screen (IntersectionObserver)
- [ ] [#032](issues/phase-2-playback/032-shared-golden-fixtures.md) Shared golden fixtures tested in both Go and JS
- [ ] [#033](issues/phase-2-playback/033-bundle-size-budget.md) Bundle size measured against the budget (under 10KB)
- [ ] [#034](issues/phase-2-playback/034-version-graceful-handling.md) Unknown or newer scene versions fail gracefully

---

## Phase 3: Publishing context
- [ ] [#035](issues/phase-3-publishing/035-artwork-aggregate-invariants.md) `Artwork` aggregate with its invariants (immutable versions, sequential numbers, owner-only, title required)
- [ ] [#036](issues/phase-3-publishing/036-artwork-domain-behaviors.md) Behaviors: `SaveDraft`, `Publish`, `Unpublish`
- [ ] [#037](issues/phase-3-publishing/037-domain-events.md) Domain events: `DraftSaved`, `VersionPublished`, `VersionUnpublished`
- [ ] [#038](issues/phase-3-publishing/038-artwork-repository-sqlite.md) `ArtworkRepository` interface and SQLite implementation, with migrations
- [ ] [#039](issues/phase-3-publishing/039-scene-compiler-port-acl.md) `SceneCompiler` port and the adapter to the Language context (the ACL)
- [ ] [#040](issues/phase-3-publishing/040-publishing-use-cases.md) Use cases: `CreateArtwork`, `SaveDraft`, `PublishArtwork`
- [ ] [#041](issues/phase-3-publishing/041-art-read-model.md) Read model for `GET /art/{id}.json`, updated on `VersionPublished`
- [ ] [#042](issues/phase-3-publishing/042-publishing-http-api.md) HTTP API: `/compile`, `/artworks`, `/art/{id}.json`, `/embed.js`
- [ ] [#043](issues/phase-3-publishing/043-server-scene-revalidation.md) Server re-validates every scene before publishing
- [ ] [#044](issues/phase-3-publishing/044-cache-headers-etags.md) Cache headers and ETags on published scenes and the runtime
- [ ] [#045](issues/phase-3-publishing/045-cors-rules-embeds.md) CORS rules for embeds
- [ ] [#046](issues/phase-3-publishing/046-rate-limits-and-quotas.md) Rate limits and request size limits
- [ ] [#047](issues/phase-3-publishing/047-minimal-identity-integration.md) Identity: minimal v1 (per the Phase 0 decision)

---

## Phase 4: Studio (client)
- [ ] [#048](issues/phase-4-studio/048-studio-live-compiler-errors.md) Editor with live compile and inline error messages at the right line
- [ ] [#049](issues/phase-4-studio/049-preview-pan-zoom-fit.md) Preview canvas with pan, zoom and fit
- [ ] [#050](issues/phase-4-studio/050-layers-panel-inspector.md) Layers panel and read-only inspector
- [ ] [#051](issues/phase-4-studio/051-examples-gallery.md) Examples gallery, starting with a "hello" piece that works in one line
- [ ] [#052](issues/phase-4-studio/052-draft-autosave.md) Autosave of the draft
- [ ] [#053](issues/phase-4-studio/053-publish-flow-copy-embed.md) Publish button, then copy embed code
- [ ] [#054](issues/phase-4-studio/054-undo-redo.md) Undo and redo
- [ ] [#055](issues/phase-4-studio/055-keyboard-shortcuts.md) Keyboard shortcuts
- [ ] [#056](issues/phase-4-studio/056-studio-accessibility.md) Accessible: labels, focus order, contrast, keyboard-only use
- [ ] [#057](issues/phase-4-studio/057-mobile-responsive-studio.md) Works on a phone-sized screen
- [ ] [#058](issues/phase-4-studio/058-editable-inspector-sourcemaps.md) Optional later: editable inspector (needs source positions from the compiler)

---

## Phase 5: Hardening
- [ ] [#059](issues/phase-5-hardening/059-threat-model.md) Threat model: what a malicious script or a malicious embedder could try
- [ ] [#060](issues/phase-5-hardening/060-content-security-policy.md) Content Security Policy for the studio and the embed script
- [ ] [#061](issues/phase-5-hardening/061-runtime-sandbox-audit.md) Verify the runtime cannot reach the DOM, network, storage or `eval`
- [ ] [#062](issues/phase-5-hardening/062-load-testing-endpoints.md) Load test of `/art/{id}.json` and the compile endpoint
- [ ] [#063](issues/phase-5-hardening/063-mobile-performance-battery.md) Performance check on a low-end phone (frame rate, battery)
- [ ] [#064](issues/phase-5-hardening/064-logging-metrics-health.md) Error and metrics logging, plus health endpoint
- [ ] [#065](issues/phase-5-hardening/065-database-backup-restore.md) Backups and restore tested

---

## Phase 6: Launch
- [ ] [#066](issues/phase-6-launch/066-documentation-suite.md) Docs: "Your first piece in 2 minutes", language reference, embed guide
- [ ] [#067](issues/phase-6-launch/067-embed-demos-and-integrations.md) Embed demo on a plain HTML page and on a popular site builder
- [ ] [#068](issues/phase-6-launch/068-usability-testing.md) 5 usability tests with non-programmers: time to first visual, where they get stuck
- [ ] [#069](issues/phase-6-launch/069-language-scene-versioning-policy.md) Versioning policy for the language and Scene schema
- [ ] [#070](issues/phase-6-launch/070-licensing-and-terms.md) Licensing and terms for published work
- [ ] [#071](issues/phase-6-launch/071-release-checklist-rollback.md) Release checklist and rollback plan

---

## Cross-Cutting Standards (Every Phase)
- [ ] Every new decision gets an ADR in `docs/adr/`
- [ ] Tests written with the code, not after (minimum 80% coverage on core domain)
- [ ] Domain code imports no infrastructure
- [ ] Contexts talk only through public APIs or ports
- [ ] Every commit leaves the build green (`go test ./...`, `go vet ./...`, `gofmt`)

---

## Success Criteria (v1 Definition of Done)
- [ ] A non-programmer makes their first visual in under 2 minutes
- [ ] The embed costs under about 10KB and runs smoothly on a low-end phone
- [ ] Published scenes cannot touch the host page
- [ ] Idea to live embed needs no help from a developer
