---
name: reqstool-openspec:init
description: Install the openspecui reqstool hook into this project. Writes openspec/openspecui.hooks.ts so openspecui enriches all OpenSpec documents (spec, changes, and archived) with reqstool requirement/SVC titles and descriptions at read time.
license: Apache-2.0
metadata:
  author: reqstool-ai
  version: "1.0"
---

Install or upgrade the reqstool openspecui hook in this project.

---

**Steps**

1. Read the version from the template: look for `// @reqstool-openspec-hooks: <version>` on the first line of `references/openspecui.hooks.ts`.

2. Check if `openspec/openspecui.hooks.ts` already exists in the project.
   - **If it does not exist**: proceed to step 3.
   - **If it exists**: read the first line and extract its `@reqstool-openspec-hooks` version (if present).
     - If the installed version matches the template version: tell the user it is already up to date and stop.
     - If the installed version is older (or the marker is missing): tell the user the current version and the new version, then ask whether to upgrade.
     - If the user declines: stop.

3. Create the `openspec/` directory if it does not exist.

4. Write `references/openspecui.hooks.ts` verbatim to `openspec/openspecui.hooks.ts` in the project root.

5. Report: tell the user the file was written (or upgraded) and remind them:
   - `reqstool` must be on PATH (install via `pipx install reqstool`)
   - The hook auto-detects `.reqstool-ai.yaml` by walking up from the project dir
   - Add `openspec/openspecui.hooks.ts` to version control
