# Fix the build

The `Build` stage just failed. Your job is to make the repository build and
pass its tests again.

## What to do

1. **Read the failure.** The previous stage output contains the build log. If
   you need more detail, re-run the build yourself with the same command the
   stage used, inside the workspace.
2. **Find the root cause.** Read the failing source files before editing.
   Do not guess from the error line alone.
3. **Fix it minimally.** Change only what the failure requires. Match the
   existing style, framework version, and conventions. Do not reformat files
   you did not need to touch.
4. **Never weaken checks.** Do not delete or skip tests, disable analyzers,
   lower warnings-as-errors, pin outdated packages, or stub code just to make
   the build pass. If a test encodes wrong behaviour, say so and fix the test
   and the code together.
5. **Re-run the build and tests locally** (for example `dotnet build` /
   `dotnet test`, `npm run build` / `npm test`, or `bash ./scripts/build.sh`)
   until they pass.
6. **Report** a short summary: the root cause, the files you changed, and the
   commands you ran with their final result.

## Rules

- Work only inside this repository checkout.
- Do not commit, push, or open pull requests; Fabro checkpoints the workspace.
- Do not add secrets, credentials, or machine-specific paths.
- If the failure cannot be fixed without a decision that belongs to the repo
  owner (for example an API contract change or a new dependency), stop, explain
  the blocker, and leave the workspace in a consistent state.
