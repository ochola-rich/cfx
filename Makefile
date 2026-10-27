# cfx Makefile

.PHONY: help build test test-language test-publishing lint fmt vet tidy dev clean

# Default target
help:
	@echo "cfx — Make targets"
	@echo ""
	@echo "Build:"
	@echo "  build           Build cfxd binary"
	@echo "  build-runtime   Build embed.js (in runtime/)"
	@echo ""
	@echo "Test:"
	@echo "  test            Run all Go tests"
	@echo "  test-language   Run language compiler golden tests"
	@echo "  test-publishing Run publishing domain tests"
	@echo "  test-runtime    Run JS runtime tests"
	@echo "  test-cover      Run tests with coverage"
	@echo ""
	@echo "Code Quality:"
	@echo "  lint            Run golangci-lint"
	@echo "  fmt             Run gofmt on all Go files"
	@echo "  vet             Run go vet"
	@echo "  tidy            Run go mod tidy"
	@echo ""
	@echo "Development:"
	@echo "  dev             Start dev server (cfxd + runtime)"
	@echo "  migrate         Run database migrations"
	@echo ""
	@echo "Maintenance:"
	@echo "  clean           Remove build artifacts"
	@echo "  deps            Download and verify dependencies"

# Build
build:
	go build -o bin/cfxd ./cmd/cfxd

build-runtime:
	cd runtime && npm run build

# Test
test:
	go test ./...

test-language:
	go test -v ./internal/language/...

test-publishing:
	go test -v ./internal/publishing/...

test-runtime:
	cd runtime && npm run test

test-cover:
	go test -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html
	@echo "Coverage report: coverage.html"

# Code Quality
lint:
	golangci-lint run ./...

fmt:
	gofmt -w -s .

vet:
	go vet ./...

tidy:
	go mod tidy
	go mod verify

# Development
dev:
	@echo "Starting dev server..."
	@echo "  cfxd: http://localhost:8080"
	@echo "  runtime: http://localhost:3000"
	@echo ""
	@echo "Run in separate terminals:"
	@echo "  Terminal 1: make run-server"
	@echo "  Terminal 2: make run-runtime"

run-server:
	go run ./cmd/cfxd serve

run-runtime:
	cd runtime && npm run dev

migrate:
	go run ./cmd/cfxd migrate

# Maintenance
clean:
	rm -rf bin/
	rm -f coverage.out coverage.html
	cd runtime && rm -rf dist/ node_modules/.cache/

deps:
	go mod download
	go mod verify
	cd runtime && npm ci

# Generate (when we add code generation)
generate:
	go generate ./...

# Install tools
install-tools:
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest