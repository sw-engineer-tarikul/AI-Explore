# AI-Explore — Data Engine starter

Minimal starter for the **Data Engine** module: a small .NET class library with
unit tests, plus the Fabro workflow used by the `Fix Build` automation.

The module owns bases, tables, fields, records, formulas and relationships.
This starter only contains field-type coercion so the build and test pipeline
has something real to run. Keep the team's module rules in the shared
`AGENTS.md` workspace, not in code comments.

## Layout

```
.fabro/workflows/patch/   Fabro "Fix Build" workflow + agent prompt
scripts/                  build / test entry points (bootstrap the .NET SDK)
src/DataEngine/           class library (net10.0)
src/DataEngine.Tests/     xUnit tests (net10.0)
```

## Build and test

```bash
bash scripts/build.sh
bash scripts/test.sh
```

The scripts install the .NET 10 SDK into `$HOME/.dotnet` when `dotnet` is not
already on `PATH`, so they work in a plain `buildpack-deps:noble` container as
well as on a developer machine.

## Automation

### 1. Fix Build
`Fix Build` (Fabro, environment `default`) checks out this repository, runs the
`patch` workflow from `.fabro/workflows/patch/`, and — if the build or tests
fail — hands the log to an agent that fixes the root cause, then re-verifies.

### 2. Web Page Generator (Data Engine Landing Page)
Generates or updates the clean, minimal static landing page (`web/index.html` + `web/styles.css`).

**How to run with a custom requirement (no markdown file editing needed):**
- **Windows (Double-click or CMD):** Run `generate-page.cmd` and type your requirement when prompted.
- **PowerShell:** `.\scripts\generate-page.ps1 -Requirement "Your landing page requirements here"`
- **Python CLI:** `python scripts/generate_page.py "Your landing page requirements here"`

If no requirement is specified, it uses the default landing page specification or falls back to `web/BRIEF.md`.
