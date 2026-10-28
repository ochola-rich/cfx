# [Phase 0] #008: Continuous Integration (CI) Pipeline Configuration

**Phase:** Phase 0: Foundations  
**Labels:** `phase:0-foundations`, `ci-cd`, `devops`, `testing`  
**Milestone:** Phase 0: Foundations  

---

## 1. Background & Context
To ensure code hygiene, consistent formatting, and immediate feedback on test failures across both Go (backend & compiler) and TypeScript (runtime & studio), a robust GitHub Actions CI workflow must run on every pull request and push to `main`.

## 2. Objective
Create automated CI workflows running linting (`gofmt`, `go vet`, `golangci-lint`), automated test suites, and bundle size checks.

## 3. Acceptance Criteria
- [ ] `.github/workflows/ci.yml` configured to trigger on `push` and `pull_request` against `main`.
- [ ] **Go Validation Job**:
  - Sets up Go (latest stable 1.22+).
  - Validates formatting using `gofmt -s -l` (fails if any files are unformatted).
  - Runs `go vet ./...`.
  - Runs `staticcheck ./...` or `golangci-lint`.
  - Executes unit and integration tests with race detector: `go test -v -race -cover ./...`.
- [ ] **JavaScript / TypeScript Runtime Job**:
  - Sets up Node.js LTS.
  - Installs dependencies with clean install (`npm ci`).
  - Runs linter and type-check (`npm run typecheck`).
  - Executes tests (`npm test`).
  - Builds runtime bundle and enforces size limit budget (`< 10KB`).
- [ ] Workflow status badges added to `README.md`.

## 4. Definition of Done (DoD)
- [ ] Workflow file committed at `.github/workflows/ci.yml`.
- [ ] Pipeline runs successfully on GitHub Actions and outputs green checkmark.
- [ ] Pull requests require passing CI checks prior to merging.
