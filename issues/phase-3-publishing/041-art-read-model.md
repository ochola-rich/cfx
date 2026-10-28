# [Phase 3] #041: Optimized Read Model for Public Embeds (GET /art/{id}.json)

**Phase:** Phase 3: Publishing context  
**Labels:** `phase:3-publishing`, `cqrs`, `performance`, `caching`  
**Milestone:** Phase 3: Publishing context  

---

## 1. Background & Context
Public embed traffic on high-traffic websites can demand thousands of reads per second on `GET /art/{id}.json`. Reconstructing the full `Artwork` aggregate and parsing JSON from SQL on every HTTP request creates needless CPU and DB overhead. A specialized CQRS read model serving pre-rendered, pre-compressed JSON directly optimizes this critical path.

## 2. Objective
Implement a high-performance Read Model projector for published scenes, updating a dedicated table/cache when `VersionPublished` events fire.

## 3. Acceptance Criteria
- [ ] Read model data schema:
  - `published_scenes` table: `artwork_id`, `version_number`, `scene_json` (raw BLOB/TEXT), `etag`, `updated_at`.
- [ ] Projection handler:
  - Listens for `VersionPublished` domain events and asynchronously or transactionally writes to `published_scenes`.
- [ ] Fast read service:
  - Query method `GetPublishedScene(ctx, artworkID) ([]byte, string, error)` returning raw bytes and ETag.
  - Zero JSON re-marshaling during read requests.
- [ ] Benchmark verifies serving reads from memory or SQLite WAL mode with sub-millisecond latency.

## 4. Definition of Done (DoD)
- [ ] Read model projector and query service implemented.
- [ ] Performance tests verify zero-alloc or low-alloc throughput.
