# [Phase 3] #038: ArtworkRepository Interface & SQLite Adapter with Migrations

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `database`, `sqlite`, `repository`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Following Clean Architecture and DDD ports-and-adapters, the domain defines the repository interface, while the infrastructure layer provides the concrete database implementation. We use SQLite for lightweight zero-dependency deployment, high-performance local queries, and seamless self-hosting.

## 2. Objective
Define the `ArtworkRepository` port in `internal/publishing/domain/repository.go` and implement the SQLite adapter with automated SQL migrations in `internal/publishing/infra/sqlite/`.

## 3. Acceptance Criteria
- [ ] `ArtworkRepository` interface defines:
  - `Save(ctx context.Context, artwork *Artwork) error`
  - `FindByID(ctx context.Context, id string) (*Artwork, error)`
  - `FindByOwner(ctx context.Context, ownerID string, limit, offset int) ([]*Artwork, error)`
  - `FindPublishedVersion(ctx context.Context, artworkID string, version int) (*Version, error)`
- [ ] Relational SQLite schema design:
  - `artworks` table: `id`, `owner_id`, `title`, `draft_script`, `created_at`, `updated_at`
  - `artwork_versions` table: `id`, `artwork_id`, `version_number`, `script`, `scene_json`, `ir_version`, `is_published`, `created_at`
- [ ] Automated schema migrations:
  - Embedded SQL migration scripts (`0001_initial_schema.sql`, etc.) executed on application startup using a migration runner.
- [ ] SQLite connection settings optimized:
  - WAL (Write-Ahead Logging) journal mode enabled (`PRAGMA journal_mode = WAL;`).
  - Foreign key constraints enabled (`PRAGMA foreign_keys = ON;`).
  - Connection pool limits configured appropriately for concurrent reads and serialized writes.

## 4. Definition of Done (DoD)
- [ ] Repository interface and SQLite implementation completed.
- [ ] Integration tests verify transactional persistence and queries against an in-memory or temp-file SQLite database.
