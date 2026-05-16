---
name: reqstool-openspec:init
description: Install the openspecui reqstool hook into this project. Writes openspec/openspecui.hooks.ts so openspecui enriches all OpenSpec documents (spec, changes, and archived) with reqstool requirement/SVC titles and descriptions at read time.
license: Apache-2.0
metadata:
  author: reqstool-ai
  version: "1.0"
---

Install the reqstool openspecui hook into this project.

---

**Steps**

1. Check if `openspec/openspecui.hooks.ts` already exists.
   - If it exists: show the user the current file and ask whether to overwrite.
   - If not: proceed.

2. Create the `openspec/` directory if it does not exist.

3. Write `references/openspecui.hooks.ts` verbatim to `openspec/openspecui.hooks.ts` in the project root.

4. Report: tell the user the file was written and remind them:
   - `reqstool` must be on PATH (install via `pipx install reqstool`)
   - The hook auto-detects `.reqstool-ai.yaml` by walking up from the project dir
   - Add `openspec/openspecui.hooks.ts` to version control
