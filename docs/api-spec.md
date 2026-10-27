# API Specification

> **Status:** Design — not yet implemented.

## Base URL

```
https://api.cfx.example.com/v1
```

## Authentication

- **Anonymous:** `POST /compile`, `GET /art/{id}.json`, `GET /embed.js`
- **Authenticated (Bearer token):** `POST /artworks`, `PUT /artworks/{id}`, `GET /artworks`, `GET /artworks/{id}`

## Endpoints

### Compile Source

Compile a script to a Scene or return diagnostics. Used by the Studio for live preview.

```
POST /compile
Content-Type: text/plain

<cfx script>
```

**Response (200):**
```json
{
  "scene": { ... },
  "irVersion": 1
}
```

**Response (400):**
```json
{
  "diagnostics": [
    { "line": 3, "column": 5, "code": "UNKNOWN_SHAPE", "message": "...", "hint": "..." }
  ]
}
```

---

### Create Artwork

Create a new artwork with an initial draft.

```
POST /artworks
Authorization: Bearer <token>
Content-Type: application/json

{
  "title": "My First Visual",
  "draft": "background #fff\ndraw circle at 100,100 radius 50"
}
```

**Response (201):**
```json
{
  "id": "art_abc123",
  "title": "My First Visual",
  "ownerId": "user_123",
  "draft": "background #fff\ndraw circle at 100,100 radius 50",
  "versions": [],
  "createdAt": "2026-01-15T10:30:00Z"
}
```

---

### Update Artwork (Save Draft)

```
PUT /artworks/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "draft": "background #000\ndraw circle at 200,200 radius 50 fill #f00"
}
```

**Response (200):** Updated artwork with new draft.

---

### Publish Version

Compile the draft and publish as a new immutable version.

```
POST /artworks/{id}/versions
Authorization: Bearer <token>
```

**Response (201):**
```json
{
  "version": 1,
  "scene": { ... },
  "sceneHash": "sha256:...",
  "source": "background #000\ndraw circle at 200,200 radius 50 fill #f00",
  "irVersion": 1,
  "publishedAt": "2026-01-15T10:35:00Z"
}
```

**Response (400):** If draft doesn't compile.

---

### Get Artwork

```
GET /artworks/{id}
Authorization: Bearer <token>
```

**Response (200):** Full artwork with all versions.

---

### List Artworks

```
GET /artworks?limit=20&offset=0
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "artworks": [ ... ],
  "total": 42
}
```

---

### Get Scene (Embed Hot Path)

Public, cacheable, no auth. This is what the runtime loads.

```
GET /art/{id}.json
```

**Response (200):**
```json
{
  "id": "art_abc123",
  "version": 1,
  "scene": { ... },
  "irVersion": 1
}
```

**Headers:**
```
Cache-Control: public, max-age=31536000, immutable
ETag: "sha256:..."
```

---

### Get Runtime

Public, cacheable.

```
GET /embed.js
```

**Response (200):** Minified JS web component (~3-10KB)

**Headers:**
```
Cache-Control: public, max-age=31536000, immutable
Content-Type: application/javascript
```

---

## Scene IR Schema (v1)

```json
{
  "irVersion": 1,
  "canvas": { "width": 400, "height": 400 },
  "background": { "type": "color", "value": "#0a0a0a" },
  "nodes": [
    {
      "type": "circle",
      "cx": 200,
      "cy": 200,
      "r": 50,
      "fill": "#ff6b6b",
      "stroke": null,
      "strokeWidth": 0,
      "opacity": 1,
      "rotate": 0
    },
    {
      "type": "repeat",
      "count": 40,
      "children": [
        { "type": "circle", "cx": "...", "cy": "...", "r": 10, "fill": "hsl(...)" }
      ]
    }
  ]
}
```

## Node Types

| Type | Required Fields | Optional Fields |
|------|-----------------|-----------------|
| `circle` | `cx`, `cy`, `r` | `fill`, `stroke`, `strokeWidth`, `opacity`, `rotate` |
| `rectangle` | `x`, `y`, `width`, `height` | `fill`, `stroke`, `strokeWidth`, `opacity`, `rotate` |
| `line` | `x1`, `y1`, `x2`, `y2` | `stroke`, `strokeWidth`, `opacity` |
| `polygon` | `cx`, `cy`, `r`, `sides` | `fill`, `stroke`, `strokeWidth`, `opacity`, `rotate` |
| `repeat` | `count`, `children` | — |

## Error Codes

| Code | HTTP | Meaning |
|------|------|---------|
| `COMPILE_ERROR` | 400 | Script failed to compile (see diagnostics) |
| `NOT_FOUND` | 404 | Artwork or version not found |
| `UNAUTHORIZED` | 401 | Missing or invalid token |
| `FORBIDDEN` | 403 | Not the owner |
| `CONFLICT` | 409 | Version already exists |
| `VALIDATION_ERROR` | 400 | Request body invalid |

## Rate Limits

| Endpoint | Limit |
|----------|-------|
| `POST /compile` | 60/min per IP |
| `GET /art/{id}.json` | 1000/min per IP (cached) |
| `GET /embed.js` | 1000/min per IP (cached) |
| Authenticated writes | 30/min per user |

## Versioning

- API version in URL path (`/v1/`)
- Scene IR version in response (`irVersion`)
- Breaking changes → new API version
- Non-breaking additions → same version