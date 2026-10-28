# [Phase 5] #065: Automated SQLite Backup, Snapshotting & Disaster Recovery Verification

**Phase:** Phase 5: Hardening  
**Labels:** `phase:5-hardening`, `database`, `sqlite`, `disaster-recovery`, `backup`  
**Milestone:** Phase 5: Hardening  

---

## 1. Background & Context
Data loss is catastrophic for creators. When running on SQLite, backing up a database file while active writes occur requires the official SQLite Online Backup API (`VACUUM INTO` or Litestream streaming replication) to prevent database corruption. A backup plan is useless unless the restore procedure is actively tested.

## 2. Objective
Implement automated hot backups for SQLite databases and write a tested disaster recovery runbook.

## 3. Acceptance Criteria
- [ ] Hot backup implementation:
  - CLI command: `cfxd backup --output=/path/to/backup.db` executing SQLite `VACUUM INTO 'backup.db'` without downtime or blocking reads.
  - Integration with Litestream or scheduled S3/GCS snapshot script.
- [ ] Automated restore verification script:
  - Script takes a generated backup snapshot, restores it to a clean container, runs integrity check (`PRAGMA integrity_check;`), and verifies all artworks and versions are intact.
- [ ] Disaster recovery runbook documented in `docs/disaster-recovery.md` with step-by-step restoration commands and RPO/RTO targets (<1 hour RPO, <15 min RTO).

## 4. Definition of Done (DoD)
- [ ] Backup command implemented in `cmd/cfxd`.
- [ ] End-to-end restore drill executed in CI or local container and documented.
- [ ] Runbook committed to `docs/disaster-recovery.md`.
