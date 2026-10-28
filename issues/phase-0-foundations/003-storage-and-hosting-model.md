# [Phase 0] #003: Architecture Decision: Storage Engine & Hosting Deployment Model

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `architecture`, `infrastructure`, `adr`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
`cfx` requires persistence for Artworks, Drafts, Published Versions (JSON Scene IR), and user/token credentials. 
We need to balance operational simplicity during early development with production scalability, zero-dependency local development, and the option for users to self-host or run entirely on a managed cloud platform.

## 2. Objective
Formulate and commit an ADR specifying:
1. **Primary Persistence Engine:** SQLite (with WAL mode, foreign keys, and pure-Go driver like `modernc.org/sqlite` vs CGO `mattn/go-sqlite3` vs PostgreSQL).
2. **Hosting Topology:** Single self-contained Go binary that embeds static assets, capable of running self-hosted, alongside a hosted multi-tenant deployment model.

## 3. Acceptance Criteria
- [ ] ADR committed at `docs/adr/0003-storage-and-hosting-model.md`.
- [ ] Evaluates SQLite vs Postgres:
  - Validates why embedded SQLite in WAL mode satisfies read-heavy traffic (`GET /art/{id}.json` served efficiently with edge caching).
  - Outlines concurrency guarantees and transaction management in Go (`database/sql` with appropriate max open connection pool tuning for SQLite).
  - Establishes repository interface design (`ArtworkRepository`) to ensure zero lock-in if switching or supporting Postgres later.
- [ ] Defines the hosting architecture:
  - Single deployable binary (`cfxd`) embedding web assets (`go:embed`).
  - Containerization strategy (minimal Alpine or scratch Docker image).
  - Volume mounting strategy for `/data/cfx.db`.
  - Self-hostable simplicity vs multi-tenant cloud operations.
- [ ] Defines data backup and snapshot strategy (SQLite Online Backup API or litestream/rsync).

## 4. Definition of Done (DoD)
- [ ] ADR reviewed and committed in `docs/adr/0003-storage-and-hosting-model.md`.
- [ ] Makefile and project documentation updated with expected deployment targets.
