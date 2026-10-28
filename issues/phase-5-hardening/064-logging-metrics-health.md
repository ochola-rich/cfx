# [Phase 5] #064: Observability: Structured Logging, Metrics & Health Check Endpoints

**Phase:** Phase 5: Hardening  
**Labels:** `phase:5-hardening`, `observability`, `monitoring`, `operations`  
**Milestone:** Phase 5: Hardening  

---

## 1. Background & Context
Production operations require deep visibility into server health, request throughput, latency distributions, error rates, and resource utilization. We need structured JSON logging, standard Prometheus metrics, and automated health check probes for container orchestrators (Docker / Kubernetes / systemd).

## 2. Objective
Implement structured logging (`log/slog`), Prometheus metrics instrumentation, and liveness/readiness probes in `cmd/cfxd`.

## 3. Acceptance Criteria
- [ ] **Structured Logging**:
  - Uses Go standard library `log/slog` outputting structured JSON in production and human-readable text in local dev.
  - Logs HTTP requests: method, path, status, duration, client IP, user agent, request ID.
  - Excludes sensitive bearer tokens or edit secrets from log output.
- [ ] **Health Check Endpoints**:
  - `GET /healthz` or `GET /live`: returns `200 OK` (liveness probe).
  - `GET /ready`: verifies SQLite database connectivity and disk write ability; returns `200 OK` or `503 Service Unavailable`.
- [ ] **Prometheus Metrics (`GET /metrics`)**:
  - `http_requests_total` partitioned by handler, method, and code.
  - `http_request_duration_seconds` histogram.
  - `compile_duration_seconds` histogram.
  - `sqlite_open_connections` and query latency.
  - Protected endpoint or restricted to internal network.

## 4. Definition of Done (DoD)
- [ ] Observability middleware and endpoints implemented.
- [ ] Integration tests verify `/healthz` and `/ready` behavior during normal operation and database disconnection.
