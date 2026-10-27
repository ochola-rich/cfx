# Language Grammar (EBNF)

> **Status:** In design — not yet implemented.

## Goals

- Plain English feel for creators
- Closed language: only what the grammar allows can be expressed
- Deterministic compilation to Scene IR
- Friendly, precise diagnostics (line + column)

## Core Concepts

- **Script** → sequence of **Statements**
- **Statement** → `draw` | `repeat` | `background` | `set`
- **Expression** → numbers, identifiers, simple math, color literals

## EBNF Grammar (Draft)

```ebnf
Script        = { Statement } ;

Statement     = DrawStmt
              | RepeatStmt
              | BackgroundStmt
              | SetStmt
              ;

DrawStmt      = "draw" Shape [ "at" Position ] [ StyleOpts ] ;
Shape         = "circle" [ Radius ]
              | "rectangle" [ Width Height ]
              | "line" [ Start End ]
              | "polygon" [ Sides ] [ Radius ]
              ;

RepeatStmt    = "repeat" Count [ "times" ] Block ;
Block         = "{" { Statement } "}" ;

BackgroundStmt= "background" Color ;

SetStmt       = "set" Identifier "=" Expression ;

Position      = Expression "," Expression ;
Radius        = Expression ;
Width         = Expression ;
Height        = Expression ;
Start         = Position ;
End           = Position ;
Sides         = Expression ;
Count         = Expression ;

StyleOpts     = { StyleOpt } ;
StyleOpt      = "fill" Color
              | "stroke" Color [ Width ]
              | "opacity" Expression
              | "rotate" Expression
              ;

Color         = HexColor | NamedColor | RGBColor | HSLColor ;
HexColor      = "#" HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit ;
NamedColor    = "red" | "blue" | "green" | "white" | "black" | ... ;
RGBColor      = "rgb" "(" Expression "," Expression "," Expression ")" ;
HSLColor      = "hsl" "(" Expression "," Expression "%" "," Expression "%" ")" ;

Expression    = Term { ("+" | "-") Term } ;
Term          = Factor { ("*" | "/") Factor } ;
Factor        = Number | Identifier | "(" Expression ")" ;
Number        = Digit { Digit } [ "." { Digit } ] ;
Identifier    = Letter { Letter | Digit | "_" } ;

Digit         = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
Letter        = "a".."z" | "A".."Z" ;
HexDigit      = Digit | "a".."f" | "A".."F" ;
```

## Example Scripts

```cfx
background #0a0a0a

draw circle at 200, 200 radius 50 fill #ff6b6b

repeat 40 times {
    set angle = index * 360 / 40
    set x = 200 + cos(angle) * 150
    set y = 200 + sin(angle) * 150
    draw circle at x, y radius 10 fill hsl(angle, 80%, 60%)
}

draw rectangle at 100, 350 width 200 height 20 fill transparent stroke #fff stroke 2
```

## Resource Limits (Enforced by Checker)

| Limit | Value | Rationale |
|-------|-------|-----------|
| Canvas width/height | ≤ 4000 | Prevents memory exhaustion |
| Max nodes in scene | ≤ 5000 | Keeps scene JSON small |
| Max repeat iterations | ≤ 1000 | Prevents infinite loops |
| Max recursion depth | ≤ 10 | Prevents stack overflow |
| Max identifier length | ≤ 64 | Keeps IR compact |

## Diagnostics Format

```json
{
  "line": 5,
  "column": 12,
  "code": "UNKNOWN_SHAPE",
  "message": "Unknown shape 'elipse'. Did you mean 'ellipse'?",
  "hint": "Available shapes: circle, rectangle, line, polygon"
}
```

## Next Steps

1. Finalize grammar with Pratt parser precedence for expressions
2. Define AST node types in Go (`internal/lang/ast`)
3. Implement lexer → parser → checker → emitter pipeline
4. Golden test suite: `.cfx` source files → expected Scene JSON