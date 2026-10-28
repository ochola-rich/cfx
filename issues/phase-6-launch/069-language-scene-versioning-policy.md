# [Phase 6] #069: Formal Evolution & Versioning Policy for Language & Scene IR

**Phase:** Phase 6: Launch  
**Labels:** `phase:6-launch`, `governance`, `versioning`, `schema`  
**Milestone:** Phase 6: Launch  

---

## 1. Background & Context
Once scenes are embedded across external websites, backward compatibility becomes permanent: old embeds must continue to render correctly for years without maintenance. Introducing new language features or changes to the Scene IR must follow a strict, predictable evolution policy.

## 2. Objective
Draft and commit `docs/versioning-policy.md` defining Semantic Versioning guarantees, schema deprecation cycles, and forward/backward compatibility rules.

## 3. Acceptance Criteria
- [ ] Versioning principles articulated:
  - **Scene IR Versioning**: Monotonically incrementing integer (`"version": 1`, `"version": 2`).
  - **Immutability Contract**: Scene schema v1 will never remove or alter existing node fields; additive optional fields only.
  - **Compiler Versioning**: Follows SemVer (`v1.x.y`). New syntactic sugar in the language must compile to existing Scene IR versions whenever possible.
  - **Runtime Compatibility**: The runtime web component must maintain backward compatibility for all prior Scene schema versions.
- [ ] Deprecation policy:
  - Minimum 12-month deprecation notice before sun-setting any legacy schema or endpoint.
- [ ] Formal RFC (Request for Comments) process outlined for proposed grammar extensions.

## 4. Definition of Done (DoD)
- [ ] `docs/versioning-policy.md` committed and referenced in `README.md`.
- [ ] Approved by core maintainers.
