# cfx

A platform where creators describe visuals in plain English, and anyone can embed the result in any site with one tag, safely and in a few KB.

## Problem

Creators who aren't programmers can't add generative, interactive visuals to a website. The tools that can do it (p5.js, Three.js, shaders) require real JavaScript. The no-code tools (Lottie, Webflow interactions) only replay fixed animations. And pasting a stranger's script into your site is a security and performance risk.

## Solution

**cfx** lets creators describe visuals in plain English, compiles them to a safe, versioned JSON scene, and provides a tiny (~3-10KB) web component runtime that anyone can embed with a single tag:

```html
<creative-canvas src="https://cfx.example.com/art/abc123.json"></creative-canvas>
```

## Key Properties

- **First visual on screen within 2 minutes**, with no programming
- **Embed costs under ~10KB** and runs smoothly on low-end phones
- **Published scenes cannot touch the host page**: no network, no DOM, no storage
- **Creator to live embed without developer help**

## Architecture

```
 Studio (editor, layers, preview)
        │ source text
        ▼
 Compiler (Go): lex → parse → check → emit
        │ Scene IR (versioned JSON)
        ▼
 Platform (Go): store, versions, gallery, embed API
        │ GET /art/{id}.json
        ▼
 Runtime (JS web component, ~3-10KB): <creative-canvas src=...>
```

## Documentation

- [Problem Statement](docs/problem-statement.md)
- [Design v1](docs/design-v1.md)
- [DDD Design](docs/ddd-design.md)
- [Language Grammar](docs/language-grammar.md) (coming soon)
- [API Specification](docs/api-spec.md) (coming soon)

## Project Structure

```
cmd/cfxd/                       Composition root
internal/
  language/                     Language context (core domain)
    scene/                      Scene, nodes, limits (value objects)
    compile/                    Lexer, parser, checker, emitter
    language.go                 Public API: Compile(...)
  publishing/                   Publishing context (core domain)
    domain/                     Artwork, Version, events, repository
    app/                        Commands and queries (use cases)
    ports/                      SceneCompiler interface (ACL boundary)
    infra/                      SQLite repo, language adapter
    http/                       HTTP handlers
  identity/                     Identity context (generic, minimal v1)
runtime/                        JS web component (Playback context)
```

## Getting Started

Coming soon - the project is in early design phase.

## License

MIT