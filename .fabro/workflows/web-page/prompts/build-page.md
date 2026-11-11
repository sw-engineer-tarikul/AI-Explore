# Task: build the Data Engine landing page

Create a static landing page for the **Data Engine** module in this repository.

## Step 1: read the requirement

{% if goal and goal != "Create a clean, minimal static landing page for the Data Engine project in plain HTML and CSS" %}
### Run Requirement (provided via goal)

{{ goal }}
{% elif inputs.requirement %}
### Run Requirement (provided via input)

{{ inputs.requirement }}
{% else %}
Read `web/BRIEF.md` first. That file is the requirement for this run and it
**overrides** the default outline below wherever the two differ. If the file is
missing or has no requirement section, use the default outline.
{% endif %}

The requirement above (whether from goal, input, or `web/BRIEF.md`) **overrides**
the default outline below wherever the two differ. If no requirement was provided,
use the default outline.

Never edit `web/BRIEF.md`.

If `web/index.html` already exists, this is an **update**, not a rewrite: keep
everything that already satisfies the brief, and change only what the brief asks
for (or what is broken). Only start from scratch when the files do not exist.

## Files to create

- `web/index.html` — the page
- `web/styles.css` — all styling

Create the `web/` directory if it does not exist.

## Hard rules

1. Create or update **only** `web/index.html` and `web/styles.css`. Do not
   modify, move or delete any existing file (no edits to `web/BRIEF.md`, `src/`,
   `scripts/`, `README.md`, or `.fabro/`).
2. Plain HTML5 + plain CSS only. **No JavaScript, no CDN links, no external
   fonts, no images, no build step.** The page must render correctly when the
   two files are opened directly from disk.
3. `web/index.html` must link the stylesheet with a relative path:
   `<link rel="stylesheet" href="styles.css" />`
4. Use only self-contained CSS in `web/styles.css`. Inline SVG (as markup) is
   allowed for small decorative icons; do not reference external assets.

## Content outline

Use this structure, in this order. Write real copy — no lorem ipsum, no
"TODO" placeholders.

1. **Header** — product name "Data Engine", a short tagline, and in-page nav
   links (Overview, Features, Quick start).
2. **Hero** — one `<h1>`, a two-sentence description of what Data Engine is
   (the module that owns bases, tables, fields, records, formulas and
   relationships), and one primary call-to-action link to the quick-start
   section. Keep it short and calm.
3. **Features** — exactly three cards, each with a heading and 1–2 sentences:
   - **Typed fields** — text, number, boolean and date, with coercion at the
     module edge so invalid input fails early.
   - **Validation at the edge** — `FieldValues.Coerce` returns a typed value or
     throws `FormatException`; empty input becomes `null`, not a default.
   - **Tested in the open** — the module ships with a real xUnit suite and a
     CI-friendly build, so behavior is proven, not assumed.
4. **Quick start** — a short paragraph plus a `<pre><code>` block showing real
   C# usage of the actual API in this repo. Use exactly these semantics:

   ```csharp
   using DataEngine;

   var age = FieldValues.Coerce(FieldType.Number, " 42 ");   // 42m
   var active = FieldValues.Coerce(FieldType.Boolean, "yes"); // true
   var due = FieldValues.Coerce(FieldType.Date, "2026-01-31"); // 2026-01-31
   var empty = FieldValues.Coerce(FieldType.Text, "  ");      // null
   ```

   Add one line showing that invalid input throws `FormatException`.
   Do not invent methods, namespaces or overloads that do not exist in
   `src/DataEngine/`.
5. **Footer** — small print with the repository name `AI-Explore` and the
   module name. No fake contact details, no dead external links.

## Style brief: clean and minimal

- Light background (near-white), dark neutral text, **one** accent color used
  sparingly (links, CTA, one decorative detail).
- Generous whitespace, a single centered content column (max-width around
  68–72rem), clear vertical rhythm.
- System font stack only, e.g.
  `-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif`.
- Monospace stack for code blocks. Code block: subtle background, padding,
  rounded corners, horizontal scroll on overflow.
- Feature cards: equal height, thin border or very soft shadow, no heavy
  gradients, no glassmorphism, no animations beyond a short color transition on
  hover.
- Headings with tight, readable sizes; body text at ~16–18px with ~1.6
  line-height.
- Responsive: single column on narrow screens; three cards become one column
  below ~720px. No horizontal scrolling at 360px width.
- Respect `prefers-reduced-motion` and keep focus styles visible.

## Accessibility and quality

- Semantic landmarks: `<header>`, `<main>`, `<section>`, `<footer>`, `<nav>`.
- Exactly one `<h1>`; headings in order (no skipped levels).
- Every `<section>` that has a heading should be labelled by it
  (`aria-labelledby` where useful).
- Sufficient color contrast (aim for WCAG AA, 4.5:1 for body text).
- `lang="en"`, `<meta charset="utf-8" />`, and a viewport meta tag.
- A descriptive `<title>` and a `<meta name="description">`.
- Wrap the code sample in `<pre><code>`; escape HTML-significant characters.

## Before you finish

Re-read both files you wrote and confirm: the stylesheet link path is correct,
there are exactly three feature cards, the quick-start snippet matches the code
in `src/DataEngine/`, and no other file in the repository was changed. Then stop.
