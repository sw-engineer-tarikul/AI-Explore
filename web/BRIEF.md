# Page brief (fallback)

This file is the fallback requirement for page generation when no run-specific
requirement (via goal or input) is provided.

To run page generation without editing this file, pass a goal or requirement input
to the run launcher. If none is passed, Fabro will fall back to reading this file.

---

## Current requirement

A landing page for the Data Engine module.

Sections, in this order:

1. **Header** — "Data Engine", a one-line tagline, and links to Overview,
   Features, and Quick start.
2. **Hero** — one headline, two sentences explaining what Data Engine is, and a
   single button that jumps to the quick start.
3. **Features** — three cards: typed fields, validation at the edge, tested in
   the open. One or two sentences each.
4. **Quick start** — a short paragraph plus a C# example that uses
   `FieldValues.Coerce` the way the module actually behaves.
5. **Footer** — the repository name `AI-Explore` and the module name.

Style: clean and minimal. Light background, one accent color, system fonts,
generous spacing, readable on a phone.

Do not add JavaScript, CDNs, external fonts, or images.

---

<!-- Fabro: read this file, do not edit it. -->
