---
name: reqstool:status
description: Run reqstool traceability status on the local filesystem. Use when the user wants to check requirement coverage, missing implementations, or test status.
license: Apache-2.0
metadata:
  author: reqstool-ai
  version: "1.0"
---

Run `reqstool status local` for a reqstool directory in this project.

---

**Input**: Optional module name from `.reqstool-ai.yaml`. Defaults to system-level.

**Configuration**

Read `.reqstool-ai.yaml` — see `reqstool-conventions.md` for field reference.

**Steps**

1. **Read config**

   Read `.reqstool-ai.yaml`. Build a mapping of module names to their paths.

2. **Determine which path to use**

   - If the user specified a module name (e.g., `core`), use that module's path from `.reqstool-ai.yaml`.
   - If no argument was given, default to the system-level path (`system.path`).
   - If the user is working inside a module directory (e.g., a Gradle subproject),
     ask whether they want to run status for that module or for the system level.

3. **Run reqstool status**

   ```bash
   reqstool status local -p <path>
   ```

   Show the output directly — reqstool traverses imports and implementation
   configuration automatically, so no further summarization is needed.

4. **If reqstool is not installed**

   If the command fails with "not found", tell the user:
   ```
   reqstool is not installed. Install with: pipx install reqstool
   ```

**Guardrails**
- Always run from the project root directory
- Do not modify any files — this is a read-only status command
- Do not summarize or reformat reqstool output — show it as-is
