# [Phase 5] #062: Load & Stress Testing for Public Read and Compile Endpoints

**Phase:** Phase 5: Hardening  
**Labels:** `phase:5-hardening`, `performance`, `load-testing`, `benchmarks`  
**Milestone:** Phase 5: Hardening  

---

## 1. Background & Context
When a creator's embedded visual goes viral on social media or high-traffic blogs, the read endpoint `GET /art/{id}.json` may experience sudden traffic spikes. Similarly, many simultaneous Studio users typing and compiling concurrently must not degrade the server. We must establish load baselines and uncover bottlenecks before launch.

## 2. Objective
Create automated load testing scripts (using k6, vegeta, or hey) simulating realistic traffic distributions and measure throughput and latency.

## 3. Acceptance Criteria
- [ ] Load test scenarios:
  - **Read Scenario (`GET /art/{id}.json`)**:
    - Target: Sustain at least 5,000 requests/second with p95 latency < 20ms and 0% errors on a standard 2-vCPU node.
    - Tests with cold cache, warm cache, and `If-None-Match` (304 responses).
  - **Write/Compile Scenario (`POST /compile`)**:
    - Target: Sustain 200 concurrent active users continuously compiling 50-line scripts without CPU exhaustion or server crashes.
- [ ] Memory and goroutine leak detection:
  - Validates that Go memory profile remains flat under sustained 15-minute load test.
  - Verifies SQLite connection pool does not exhaust file descriptors or lock tables.
- [ ] Automated k6 script committed to `tests/load/load-test.js` with documented run instructions.

## 4. Definition of Done (DoD)
- [ ] Load tests executed and documented in `docs/load-test-results.md`.
- [ ] Target throughput and latency milestones verified.
