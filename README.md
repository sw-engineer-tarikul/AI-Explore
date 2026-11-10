# AI-Explore — Data Engine starter

Minimal starter for the **Data Engine** module: a small .NET class library with
unit tests, plus the Fabro workflow used by the `Fix Build` automation.

The module owns bases, tables, fields, records, formulas and relationships.
This starter only contains field-type coercion so the build and test pipeline
has something real to run. Extend it following `src/DataEngine/AGENTS.md`
(kept in the team workspace; do not move module rules into code comments).

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

`Fix Build` (Fabro, environment `default`) checks out this repository, runs the
`patch` workflow from `.fabro/workflows/patch/`, and — if the build or tests
fail — hands the log to an agent that fixes the root cause, then re-verifies.
