---
name: reqstool:status
description: Run reqstool traceability status on the local filesystem. Use when the user wants to check requirement coverage, missing implementations, or test status.
license: Apache-2.0
metadata:
  author: reqstool-ai
  version: "1.0"
---

Show requirements traceability status. Uses the reqstool MCP server if configured, falls back to the CLI.

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

3. **Try MCP first**

   Call the `reqstool` MCP server `get_status` tool.

   - If it succeeds: present the returned status (requirements met/total, test summary).
     Note: the MCP server always reflects the system-level path it was started with.
     If the user asked for a specific module and the MCP result does not scope to that path,
     note this limitation and proceed to the CLI fallback for the module path.

4. **Fall back to CLI**

   If the MCP server is not configured or the call fails, immediately tell the user:

   > The reqstool MCP server is not configured — falling back to CLI.

   Then run:

   ```bash
   reqstool status local -p <path>
   ```

   Show the output directly — reqstool traverses imports and implementation
   configuration automatically, so no further summarization is needed.

5. **If neither works**

   If `reqstool` CLI is also not found, tell the user:

   > Both the reqstool MCP server and CLI are unavailable.
   > - To install the CLI: `pipx install reqstool`
   > - To configure the MCP server: run `/reqstool:init`

**Guardrails**
- Always run from the project root directory
- Do not modify any files — this is a read-only status command
- Do not summarize or reformat reqstool CLI output — show it as-is
