# [Phase 0] #002: Architecture Decision: v1 Creator Identity Model (Sign-in vs Anonymous Secret Edit Link)

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `architecture`, `security`, `adr`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
A core premise of `cfx` is delivering the first working visual within 2 minutes with minimum cognitive friction. Requiring mandatory account sign-up before creating or saving a visual introduces onboarding friction. However, allowing completely anonymous creation without recovery mechanisms risks losing ownership or enabling unauthorized modifications.

We must evaluate two primary v1 patterns:
1. **Option A: Anonymous with Secret Edit Link / Bearer Token**
   - Creator visits studio, creates draft immediately.
   - On initial save/publish, system generates a cryptographic secret token (e.g. `cfx_sk_...`) returned in a private edit link (`cfx.dev/edit/{id}#secret=...`).
   - Read/embed endpoint is public (`cfx.dev/art/{id}.json`).
   - Optional future account linking / claiming.
2. **Option B: Lightweight Federated Sign-In (OAuth / OIDC / Magic Link)**
   - Minimal authentication upfront (e.g., GitHub, Google, or Passwordless Email Magic Link).
   - Direct creator attribution in database (`owner_id`).

## 2. Objective
Document an Architecture Decision Record (ADR) analyzing trade-offs, security implications, migration path, and choose the canonical v1 identity model.

## 3. Acceptance Criteria
- [ ] ADR document created at `docs/adr/0002-v1-identity-model.md` following standard ADR format (Status, Context, Decision Drivers, Considered Options, Decision Outcome, Pros & Cons).
- [ ] Evaluation addresses:
  - Friction to first visual (< 2 minute goal).
  - Risk of lost edit URLs vs user account recovery support overhead.
  - Authorization check logic on `PUT /artworks/{id}` and `POST /artworks/{id}/publish`.
  - Rate limiting and bot abuse mitigation per IP or per token.
  - Future migration path: how anonymous artworks can be claimed once full sign-in is introduced.
- [ ] Final decision clearly chosen and agreed upon by the engineering team.

## 4. Definition of Done (DoD)
- [ ] ADR committed to `docs/adr/0002-v1-identity-model.md`.
- [ ] Checklist item in `CHECKLIST.md` updated with the final decision.
- [ ] Any updates reflected in `docs/ddd-design.md` (Identity bounded context).
