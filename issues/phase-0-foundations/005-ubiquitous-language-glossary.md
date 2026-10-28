# [Phase 0] #005: Formalize Ubiquitous Language Glossary in Repository

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `ddd`, `documentation`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
A core principle of Domain-Driven Design is maintaining a shared, unambiguous Ubiquitous Language across engineers, designers, creators, and UI copy. Casual or interchangeable usage of terms (e.g. using "file", "project", "canvas", "template" to mean an "Artwork" or "Script") leads to conceptual confusion, flawed schemas, and brittle code.

## 2. Objective
Establish a canonical Ubiquitous Language glossary committed to `docs/glossary.md` and enforce strict naming conventions across Go packages, API schemas, and frontend interfaces.

## 3. Acceptance Criteria
- [ ] Comprehensive glossary committed at `docs/glossary.md` defining core domain terminology:
  - **Script**: The human-readable English-like text written by a creator.
  - **Statement**: A single atomic visual command (e.g. `draw circle...`, `repeat...`).
  - **Diagnostic**: Precise compiler feedback containing line, column, error code, friendly message, and actionable hint.
  - **Scene (Scene IR)**: The compiled, deterministic, validated, versioned JSON intermediate representation.
  - **Artwork**: The aggregate root entity owning an ID, title, owner identity, current draft, and publication history.
  - **Draft**: The mutable, working script of an Artwork (which may temporarily contain compiler errors).
  - **Version**: An immutable published snapshot consisting of both the source script and compiled Scene IR.
  - **Publish**: The atomic operation converting a valid draft into a sealed version.
  - **Embed**: The public read-only endpoint and HTML snippet (`<creative-canvas>`) rendering an artwork.
  - **Runtime**: The sandboxed browser client (web component) executing the Scene IR frame-by-frame.
- [ ] Explicit "Forbidden / Discouraged Terms" table provided (e.g., forbidding "Project", "File", "Template", "Code Snippet").
- [ ] Code conventions defined mapping domain nouns to Go struct types and TS interfaces.

## 4. Definition of Done (DoD)
- [ ] `docs/glossary.md` is committed and linked from `README.md` and `docs/ddd-design.md`.
- [ ] Team guidelines updated in `CONTRIBUTING.md` referencing the glossary.
