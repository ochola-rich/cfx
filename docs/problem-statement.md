# Problem Statement

## Draft Problem Statement

> Creators who aren't programmers can't add generative, interactive visuals to a website. The tools that can do it (p5.js, Three.js, shaders) require real JavaScript. The no-code tools (Lottie, Webflow interactions) only replay fixed animations. And pasting a stranger's script into your site is a security and performance risk.

## Pain Points

| Who | Pain Today |
|-----|------------|
| **Creators** (designers, artists, educators, hobbyists) | They have ideas for living, reactive visuals but can't code them, and drag-and-drop tools can't express "40 circles that follow a wave and react to the mouse". |
| **Site owners** (people embedding the result) | They don't want to audit third-party JavaScript, add a 200KB+ library, or risk their page being hijacked. |
| **Visitors** | They get slow pages and heavy animation on cheap phones and slow connections. |

## What cfx Is

A platform where creators describe visuals in plain English, and anyone can embed the result in any site with one tag, safely and in a few KB.

## Success Criteria

- A first visual is on screen within **2 minutes**, with no programming
- The embed costs **under ~10KB** and runs smoothly on a low-end phone
- Published scenes **cannot touch the host page**: no network, no DOM, no storage
- A creator can go from **idea to live embed** without help from a developer

## Non-Goals (for Now)

- General-purpose programming
- 3D
- Video export
- Real-time collaboration