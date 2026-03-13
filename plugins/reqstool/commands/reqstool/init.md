---
name: "Reqstool: Init"
description: Create or update .reqstool-ai.yaml configuration for this project
category: Requirements
tags: [reqstool, init, config, setup]
---

Create or update `.reqstool-ai.yaml` configuration for this project.

## Steps

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
   Include comments explaining each section.

   Format:
   ```yaml
   # reqstool-ai configuration
   #
   # This file tells reqstool-ai skills where to find your reqstool files
   # and how to generate IDs for new requirements and SVCs.

   # Project URN — matches the urn in your reqstool YAML files
   urn: <urn>

   # Revision string for new requirements and SVCs
   revision: "<revision>"

   # System-level reqstool directory (contains the SSOT requirements and SVCs)
   system:
     path: <system-path>

   # Subproject modules — each module imports a subset of requirements/SVCs via filters
   modules:
     <name>:
       path: <module-path>
       req_prefix: <prefix>
       svc_prefix: <svc-prefix>
   ```

5. **Verify (if possible)**

   If `reqstool` CLI is installed **and** the system path contains existing reqstool files,
   run `reqstool status local -p <system.path>` to verify the config.

   If reqstool is not installed or files don't exist yet, skip verification and
   tell the user they can run `/reqstool:status` later once their reqstool files are in place.

6. **Report**

   Show the user:
   - The created/updated config (print the file contents)
   - Whether this was a new file or an update
   - Remind them to add `.reqstool-ai.yaml` to version control
   - Next steps: "Run `/reqstool:add-req` to add your first requirement,
     or `/reqstool:status` to check traceability status."

## Guardrails

- Never overwrite an existing `.reqstool-ai.yaml` without reading it first and using it as defaults
- Always confirm values with the user — never silently write a config
- Directories and files referenced in the config do not need to exist yet
- At least one module is required
- Preserve any comments or extra fields in an existing config that are not part of the standard schema
