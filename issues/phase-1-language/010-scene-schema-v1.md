# [Phase 1] #010: Scene Schema v1 Specification & Versioning

**Phase:** Phase 1: Language context (core)  
**Labels:** `phase:1-language`, `schema`, `contract`  
**Milestone:** Phase 1: Language context  

---

## 1. Background & Context
The Scene intermediate representation (IR) is the *Published Language* contract between the Go compiler and the JavaScript playback runtime. Embeds must remain stable indefinitely; once a scene is published, any compliant runtime must be able to render it without breaking changes.

## 2. Objective
Formally specify and document the JSON Schema for Scene v1 (`"version": 1`) and implement corresponding Go structs in `internal/language/scene/`.

## 3. Acceptance Criteria
- [ ] JSON Schema v1 written and committed to `docs/scene-schema-v1.json`.
- [ ] Schema root requires:
  - `"version": 1`
  - `"canvas": { "width": number, "height": number, "background": string }`
  - `"nodes": [ ... ]` (ordered array of render nodes)
- [ ] Node specifications:
  - `shape`: `"type": "circle" | "rectangle" | "line"` with properties (x, y, radius, width, height, fill, stroke, strokeWidth, opacity, rotation).
  - Dynamic expressions represented as expression trees: `{ "op": "+", "args": [...] }` or `{ "fn": "sin", "args": [...] }` or literal values `{ "val": 10 }` or dynamic symbols `{ "var": "time" | "mouse_x" | "mouse_y" }`.
- [ ] Go types created in `internal/language/scene/scene.go` with complete JSON serialization tags.
- [ ] Schema validation tests ensure valid scenes marshal/unmarshal correctly without data loss.

## 4. Definition of Done (DoD)
- [ ] `docs/scene-schema-v1.json` committed.
- [ ] Go struct models implemented in `internal/language/scene/`.
- [ ] Unit tests pass verifying serialization and schema compliance.
