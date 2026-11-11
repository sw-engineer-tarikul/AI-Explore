# Task: review the new landing page (read-only)

You are reviewing a change that adds a static landing page. **Do not edit any
file.** Read only.

## What to inspect

- `web/index.html`
- `web/styles.css`
- `src/DataEngine/FieldType.cs` and `src/DataEngine/FieldValues.cs` (to check the
  quick-start snippet for accuracy)

## Checks

1. **Files and wiring** — `web/index.html` links `styles.css` with a relative
   path; there are no external network references (CDN, fonts, images, JS).
2. **Content** — header, hero with a single `<h1>`, exactly three feature cards,
   a quick-start section with a `<pre><code>` C# block, and a footer. No lorem
   ipsum, no placeholder text, no fake links.
   Then check the page against the run requirement:
   {% if goal and goal != "Create a clean, minimal static landing page for the Data Engine project in plain HTML and CSS" %}
   Requirement (from goal): {{ goal }}
   {% elif inputs.requirement %}
   Requirement (from input): {{ inputs.requirement }}
   {% else %}
   Check against `web/BRIEF.md` (or the default outline below if absent).
   {% endif %}
   Every section the requirement asks for is present, and nothing extra was invented that contradicts it.
3. **Accuracy** — every API call in the snippet exists in
   `src/DataEngine/FieldValues.cs` with the same semantics (empty input returns
   `null`, invalid input throws `FormatException`).
4. **Accessibility** — semantic landmarks, heading order, `lang`, viewport meta,
   descriptive `<title>`, visible focus styles, contrast likely to meet WCAG AA.
5. **Style** — clean and minimal: light background, one accent color, generous
   spacing, responsive single column, cards collapse on narrow screens.
6. **Scope** — only `web/index.html` and `web/styles.css` were added; no
   existing file was modified.

## Output

Reply with a short report, at most 15 lines:

- **Verdict**: `PASS` or `PASS WITH NITS` or `FAIL`.
- **Blocking issues**: at most 3 bullets (only if FAIL), each with file, line,
  and the concrete fix.
- **Nits**: at most 3 bullets.
- **Snippet accuracy**: one line confirming the C# examples match the module.

Be specific and terse. Do not restate the page contents.
