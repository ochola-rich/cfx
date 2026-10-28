# [Phase 3] #043: Server-Side Scene IR Re-Validation Before Publishing

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `security`, `validation`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Client applications (such as the Studio) perform client-side and live previews. However, the server must NEVER trust pre-compiled scenes supplied by a client. A compromised or malicious client could attempt to submit crafted Scene IR payloads containing oversized canvases, billions of shapes, or invalid properties.

## 2. Objective
Enforce strict server-side recompilation and invariant re-validation within the `PublishArtwork` use case before any scene is committed to the database or read model.

## 3. Acceptance Criteria
- [ ] During `PublishArtwork`, the server takes ONLY the raw source `script` string from the draft.
- [ ] The server executes `SceneCompiler.Compile(script)` in an isolated, resource-bounded server environment.
- [ ] The generated Scene IR is verified against the official JSON schema (`docs/scene-schema-v1.json`) and resource limits (`limits.go`).
- [ ] Any attempt to submit raw Scene IR directly via the publish API without compiling valid source script is rejected with `400 Bad Request`.
- [ ] Guarantees that no corrupted, oversized, or malicious Scene JSON can ever enter the publishing database.

## 4. Definition of Done (DoD)
- [ ] Server-side recompilation verified in use case tests.
- [ ] Negative test cases verify that invalid scripts or forged scenes are rejected with clear error codes.
