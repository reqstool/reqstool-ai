---
name: reqstool:init
description: Create or update .reqstool-ai.yaml configuration for a project. Use when the user wants to initialize or reconfigure reqstool-ai settings.
license: Apache-2.0
metadata:
  author: reqstool-ai
  version: "1.0"
---

Create or update `.reqstool-ai.yaml` configuration for this project.

---

**Input**: None required. Existing config is used as defaults when present.

**Steps**

1. **Check for existing config**

   Check if `.reqstool-ai.yaml` already exists in the project root.

   **If it exists:** read it, show the user the current config, and say
   "I found an existing `.reqstool-ai.yaml`. I'll use it as a starting point —
   you can update any values or add/remove modules."
   Pre-fill all prompts below with the existing values.

   **If it does not exist:** start fresh with empty/default values.

2. **Gather project-level config**

   Use **AskUserQuestion** to collect each value. When updating an existing config,
   show the current value and ask if the user wants to change it.

   - **URN**: The project URN used in reqstool YAML files and filter keys.
     No default for new projects — the user must provide this.
     Example: `my-project`
   - **Revision**: Version string stamped on new requirements and SVCs.
     Default: `"0.1.0"`
   - **System path**: Path to the system-level reqstool directory that will contain
     the SSOT `requirements.yml` and `software_verification_cases.yml`.
     Default: `docs/reqstool`

   Note: these directories and files do not need to exist yet. The user may be
   setting up reqstool for the first time.

3. **Gather modules**

   A module is a subproject that imports a subset of requirements/SVCs from the
   system level via filters. Projects typically have one or more modules.

   **If updating:** show the existing modules and ask the user which to keep,
   modify, or remove. Then ask if they want to add new modules.

   **If new:** explain what a module is and ask the user to define their first one.

   For each module, collect:
   - **Name**: Short identifier used in commands (e.g., `core`, `app`, `cli`).
     This becomes the key in the YAML and is used in commands like
     `/reqstool:add-req core`.
   - **Path**: Path to the module's reqstool directory (will contain filter files).
     Example: `core/docs/reqstool`
   - **req_prefix**: Requirement ID prefix for this module (e.g., `CORE_`, `CLI_`, `AUTH_`).
     All requirement IDs for this module will start with this prefix.
     Set to empty string `""` for projects using domain-specific prefixes where
     IDs are managed manually.
   - **svc_prefix**: SVC ID prefix for this module (e.g., `SVC_CORE_`, `SVC_CLI_`).
     Typically `SVC_` followed by the req_prefix.

   After each module, ask: "Add another module? (yes/no)"
   Continue until the user says no or indicates they are done.

   At least one module is required.

4. **Write the config file**

   Write `.reqstool-ai.yaml` to the project root with the collected values.
   Use `references/reqstool-ai.yaml.template` as the template — follow its
   structure, comments, and formatting. Replace placeholder values with the
   user's inputs and include only the modules the user defined.

5. **Configure MCP server (optional)**

   Offer to configure the reqstool MCP server (requires reqstool ≥ 0.10.0):

   > The reqstool MCP server gives AI tools structured access to your requirements.
   > Would you like me to add the MCP server configuration?

   If yes, use **AskUserQuestion** to ask the scope:
   - **Project** — `.mcp.json` in the project root (shared with the team via version control)
   - **Global** — `~/.config/claude/mcp.json` (just for you, not committed)

   Read the chosen file (create if missing) and add or update the `reqstool` entry:

   ```json
   {
     "mcpServers": {
       "reqstool": {
         "command": "reqstool",
         "args": ["mcp"]
       }
     }
   }
   ```

   `reqstool mcp` (no arguments) auto-detects the dataset by walking up from
   the server's working directory to find `.reqstool-ai.yaml` and using its
   `system.path` — so this same config is portable across contributors.

   If the chosen file already has a `reqstool` entry, show it and ask before overwriting.

   If `reqstool` is not yet installed, skip this step and tell the user:
   > Install reqstool first (`pipx install reqstool`), then re-run `/reqstool:init`
   > or add the MCP config manually.

6. **Verify (if possible)**

   If `reqstool` CLI is installed **and** the system path contains existing reqstool files,
   run `reqstool status local -p <system.path>` to verify the config.

   If reqstool is not installed or files don't exist yet, skip verification and
   tell the user they can run `/reqstool:status` later once their reqstool files are in place.

7. **Report**

   Show the user:
   - The created/updated config (print the file contents)
   - Whether this was a new file or an update
   - Whether the MCP server was configured and in which scope
   - Remind them to add `.reqstool-ai.yaml` to version control (and `.mcp.json` if project-scoped)
   - Next steps: "Run `/reqstool:add-req` to add your first requirement,
     or `/reqstool:status` to check traceability status."

**Guardrails**
- Never overwrite an existing `.reqstool-ai.yaml` without reading it first and using it as defaults
- Always confirm values with the user — never silently write a config
- Directories and files referenced in the config do not need to exist yet
- At least one module is required
- Preserve any comments or extra fields in an existing config that are not part of the standard schema
