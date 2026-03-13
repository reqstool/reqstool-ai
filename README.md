[![Commit Activity](https://img.shields.io/github/commit-activity/m/reqstool/reqstool-ai?label=commits&style=for-the-badge)](https://github.com/reqstool/reqstool-ai/pulse)
[![GitHub Issues](https://img.shields.io/github/issues/reqstool/reqstool-ai?style=for-the-badge&logo=github)](https://github.com/reqstool/reqstool-ai/issues)
[![License](https://img.shields.io/github/license/reqstool/reqstool-ai?style=for-the-badge&logo=opensourceinitiative)](https://opensource.org/license/mit/)
[![Documentation](https://img.shields.io/badge/Documentation-blue?style=for-the-badge&link=docs)](https://reqstool.github.io)

# Reqstool AI Integration

AI-assisted management of [reqstool](https://github.com/reqstool/reqstool-client) requirements traceability, with optional [OpenSpec](https://github.com/openspec-dev/openspec) integration.

Provides config-driven skills and commands that let AI coding assistants help you manage requirements, verification cases, and traceability filters. Works with both **Claude Code** and **GitHub Copilot CLI** — same plugin, same format.

## Quick start

### Claude Code

```bash
# Add marketplace (one-time)
/plugin marketplace add reqstool/reqstool-ai

# Install core plugin
/plugin install reqstool@reqstool-ai --scope project

# Optional: OpenSpec integration
/plugin install reqstool-openspec@reqstool-ai --scope project
```

### GitHub Copilot CLI

```bash
# Add marketplace (one-time)
copilot plugin marketplace add reqstool/reqstool-ai

# Install core plugin
copilot plugin install reqstool@reqstool-ai

# Optional: OpenSpec integration
copilot plugin install reqstool-openspec@reqstool-ai
```

### Configure your project

After installing the plugin, run `/reqstool:init` to create `.reqstool-ai.yaml` in your project root:

```
/reqstool:init
```

This walks you through setting up:
- **URN** — your project identifier used in reqstool YAML files
- **Revision** — version string for new requirements and SVCs
- **System path** — where the system-level requirements and SVCs live
- **Modules** — one or more subproject modules with their paths and ID prefixes

You can re-run `/reqstool:init` at any time to update the config (e.g., to add new modules). It reads the existing `.reqstool-ai.yaml` and uses current values as defaults.

## Configuration (`.reqstool-ai.yaml`)

All reqstool skills and commands read `.reqstool-ai.yaml` from the project root. This file defines your project's reqstool structure:

```yaml
# Project URN — matches the urn in your reqstool YAML files
urn: my-project

# Revision string for new requirements and SVCs
revision: "0.1.0"

# System-level reqstool directory (SSOT for requirements and SVCs)
system:
  path: docs/reqstool

# Subproject modules — each imports a subset of requirements/SVCs via filters
modules:
  core:
    path: core/docs/reqstool
    req_prefix: CORE_           # Requirement IDs: CORE_0001, CORE_0002, ...
    svc_prefix: SVC_CORE_       # SVC IDs: SVC_CORE_0001, SVC_CORE_0002, ...
  app:
    path: app/docs/reqstool
    req_prefix: CLI_
    svc_prefix: SVC_CLI_
```

| Field | Description |
|-------|-------------|
| `urn` | Project URN used in reqstool YAML files and filter keys |
| `revision` | Version string stamped on new requirements and SVCs |
| `system.path` | Path to the system-level reqstool directory (SSOT) |
| `modules.<name>.path` | Path to a subproject's reqstool directory (contains filter files) |
| `modules.<name>.req_prefix` | Requirement ID prefix (e.g., `CORE_`). Set to `""` for domain-specific prefixes |
| `modules.<name>.svc_prefix` | SVC ID prefix (e.g., `SVC_CORE_`) |

## Skills and commands

### Commands (user-invoked)

| Command | Description |
|---------|-------------|
| `/reqstool:init` | Create or update `.reqstool-ai.yaml` configuration interactively |
| `/reqstool:add-req` | Add a new requirement and update subproject filters |
| `/reqstool:add-svc` | Add a new Software Verification Case and update filters |
| `/reqstool:status` | Show requirements traceability status for system or a module |
### Skills (auto-applied)

| When you're... | Skill |
|---|---|
| Working with reqstool YAML files or annotations | `reqstool-conventions` |

Skills are applied automatically based on context — no manual invocation needed.

#### reqstool-openspec plugin (separate install)

| When you're... | Skill |
|---|---|
| Working with OpenSpec spec.md files | `reqstool-openspec` |

## Command details

### `/reqstool:init`

Interactively create or update `.reqstool-ai.yaml` in your project root. Walks you through URN, revision, system path, and module definitions (name, path, ID prefixes). When re-run on a project that already has a config, it reads existing values as defaults so you can add modules or change settings without starting over.

### `/reqstool:add-req`

Add a new requirement to the system-level `requirements.yml` (the single source of truth) and update the relevant subproject filter to include it. Automatically determines the next ID based on the module's `req_prefix`, supports parent-child decomposition with dot-notation IDs (e.g., `CLI_0004.1`), and reminds you to annotate the implementation with `@Requirements`.

### `/reqstool:add-svc`

Add a new Software Verification Case (SVC) to the system-level `software_verification_cases.yml` and update the subproject filter. Given a requirement ID, it drafts a GIVEN/WHEN/THEN scenario, mirrors the requirement's ID structure for the SVC ID, and reminds you to annotate the test with `@SVCs`.

### `/reqstool:status`

Run `reqstool status local` for the system or a specific module. Accepts an optional module name (e.g., `/reqstool:status core`); defaults to the system-level path from `.reqstool-ai.yaml`. Reqstool traverses imports and implementation config automatically.

## Skill details

### reqstool-conventions

Bundled convention docs that are auto-applied when working with reqstool files:

- **reqstool-conventions.md** — overview of config fields and skill conventions
- **reqstool-annotation-conventions.md** — `@Requirements` and `@SVCs` placement rules (Java, Python, TypeScript)
- **reqstool-decomposition-conventions.md** — parent-child hierarchies, dot-notation IDs, lifecycle states

### reqstool-openspec (separate plugin)

Install: `/plugin install reqstool-openspec@reqstool-ai --scope project`

OpenSpec integration conventions, auto-applied when working with spec.md files:

- **reqstool-openspec-conventions.md** — how to reference reqstool IDs in OpenSpec specs
- **config-rules.yaml** — reqstool rules for openspec/config.yaml

## Prerequisites

- [reqstool CLI](https://github.com/reqstool/reqstool-client) (`pipx install reqstool`)
- [OpenSpec](https://github.com/openspec-dev/openspec) (optional)

## Repo structure

```
reqstool-ai/
├── .claude-plugin/
│   └── marketplace.json              # Claude Code marketplace manifest
├── .github/
│   └── plugin/
│       └── marketplace.json          # Copilot CLI marketplace manifest
├── plugins/
│   ├── reqstool/                     # Core plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── skills/
│   │   │   ├── reqstool-init/
│   │   │   │   ├── SKILL.md
│   │   │   │   └── references/
│   │   │   │       └── reqstool-ai.yaml.template
│   │   │   ├── reqstool-add-req/
│   │   │   ├── reqstool-add-svc/
│   │   │   ├── reqstool-status/
│   │   │   └── reqstool-conventions/
│   │   │       ├── SKILL.md
│   │   │       └── references/       # Bundled convention docs
│   │   └── commands/
│   │       └── reqstool/
│   └── reqstool-openspec/            # OpenSpec integration plugin
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
│           └── reqstool-openspec/
│               ├── SKILL.md
│               └── references/       # Bundled OpenSpec docs
├── docs/                             # Antora documentation
├── CLAUDE.md
├── README.md
├── CONTRIBUTING.md
└── LICENSE
```

## Testing locally

```bash
# Claude Code
claude --plugin-dir ./plugins/reqstool
claude --plugin-dir ./plugins/reqstool-openspec

# Copilot CLI
copilot plugin install --path ./plugins/reqstool
copilot plugin install --path ./plugins/reqstool-openspec
```

## Updating

```bash
# Claude Code
/plugin update reqstool@reqstool-ai
/plugin update reqstool-openspec@reqstool-ai

# Copilot CLI
copilot plugin update reqstool@reqstool-ai
copilot plugin update reqstool-openspec@reqstool-ai
```

## Contributing

See the organization-wide [CONTRIBUTING.md](https://github.com/reqstool/.github/blob/main/CONTRIBUTING.md).

### Adding or updating plugin content

1. Make your changes in `plugins/reqstool/` or `plugins/reqstool-openspec/`.
2. Bump the version in the changed plugin's `.claude-plugin/plugin.json`.
3. Bump `metadata.version` in both `.claude-plugin/marketplace.json` and `.github/plugin/marketplace.json`.
4. Test locally with `claude --plugin-dir ./plugins/<plugin-name>`.
5. Submit a PR.

## Documentation

Full documentation can be found [here](https://reqstool.github.io).

## License

Apache 2.0 -- see [LICENSE](LICENSE).
