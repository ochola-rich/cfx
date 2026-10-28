# [Phase 6] #071: Production Release Checklist & Automated Rollback Plan

**Phase:** Phase 6: Launch  
**Labels:** `phase:6-launch`, `devops`, `release`, `runbook`  
**Milestone:** Phase 6: Launch  

---

## 1. Background & Context
Deploying v1 to production requires an orderly, reproducible deployment runbook with explicit pre-flight verification, automated smoke tests, and an instant rollback strategy should an unexpected regression occur.

## 2. Objective
Create `docs/release-checklist.md` with step-by-step procedures for cutting a release, running migrations, executing post-deploy smoke tests, and initiating emergency rollbacks.

## 3. Acceptance Criteria
- [ ] **Pre-Flight Checks**:
  - All CI tests green on `main`.
  - Bundle size check verified (< 10KB).
  - Database migrations tested on staging replica.
  - Security headers and CSP verified.
  - Zero open blockers on milestone.
- [ ] **Release Deployment Procedure**:
  - Automated binary build and container image tagging (`v1.0.0`).
  - Blue/Green or rolling deployment step commands.
  - Smoke test suite: automatically checks `/healthz`, compiles sample script, publishes test artwork, and loads embed script.
- [ ] **Rollback Runbook**:
  - One-command rollback procedure reverting traffic to previous image tag.
  - Database backward-compatible migration rollback steps.
  - Incident response communication template.

## 4. Definition of Done (DoD)
- [ ] `docs/release-checklist.md` committed.
- [ ] Dry-run release and rollback drill successfully executed on staging environment.
