# Contributing to cfx

## Development Setup

### Prerequisites

- Go 1.22+
- Node.js 20+ (for runtime)
- SQLite3 (for local development)

### Quick Start

```bash
# Clone and enter
git clone https://github.com/ochola-rich/cfx.git
cd cfx

# Install Go dependencies
go mod download

# Install runtime dependencies
cd runtime && npm install && cd ..

# Run tests
make test

# Start dev server (when implemented)
make dev
```

## Project Conventions

### Go

- **Standard library first** — avoid external dependencies in domain code
- **Hexagonal architecture** — domain imports nothing from infrastructure
- **Context-per-module** — `internal/language`, `internal/publishing`, `internal/identity`
- **Interfaces in domain** — repositories, ports defined in domain packages
- **Errors with context** — use `fmt.Errorf("...: %w", err)` for wrapping

### JavaScript/TypeScript (Runtime)

- **Zero dependencies** in the published `embed.js`
- **TypeScript strict mode** — no `any`, explicit types
- **Pure functions** — renderer is `draw(ctx, scene, time, pointer)`
- **Shared types** — Scene IR types generated from Go or kept in sync manually

### Git

- **Conventional Commits** — `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`
- **Small, focused commits** — one logical change per commit
- **Descriptive messages** — explain *why*, not just *what*

## Testing

### Go

```bash
# All tests
make test

# Language compiler golden tests
make test-language

# Publishing domain tests
make test-publishing

# With coverage
make test-cover
```

### Runtime

```bash
cd runtime
npm run test          # Golden + snapshot tests
npm run test:watch    # Watch mode
npm run test:update   # Update snapshots
```

### Golden Tests (Cross-Language)

The `runtime/test/golden/fixtures/` directory contains test cases that verify both the Go compiler and JS runtime produce identical results.

```
fixtures/
├── 01_basic_circle/
│   ├── source.cfx      # Input script
│   ├── scene.json      # Expected Scene IR (from Go compiler)
│   └── drawops.json    # Expected draw operations (from JS renderer)
```

## Code Review Checklist

- [ ] Domain logic has no infrastructure imports
- [ ] New types have smart constructors enforcing invariants
- [ ] Diagnostics include line, column, code, message, and hint
- [ ] Resource limits enforced (canvas size, node count, repeat iterations)
- [ ] Golden test added for new language features
- [ ] Runtime bundle size stays under 10KB (min+gzip)
- [ ] No `unsafe`, `reflect`, or `syscall` in domain code

## Adding a Language Feature

1. Update EBNF in `docs/language-grammar.md`
2. Add AST node in `internal/language/compile/ast/ast.go`
3. Extend parser in `internal/language/compile/parser/parser.go`
4. Add checking rules in `internal/language/compile/check/check.go`
5. Add emission in `internal/language/compile/emit/emit.go`
6. Add Scene node type in `internal/language/scene/nodes.go`
7. Add golden test in `runtime/test/golden/fixtures/`
8. Update runtime renderer in `runtime/src/renderer.ts`
9. Update TypeScript types in `runtime/src/scene.ts`

## Releasing

```bash
# Tag a version
git tag v0.1.0
git push origin v0.1.0

# CI builds and publishes:
# - Go binary (cfxd)
# - embed.js to CDN
# - Docker image
```

## Code of Conduct

Be kind. Assume good intent. Help each other learn.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.