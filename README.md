# reqstool-ai

AI-assisted management of [reqstool](https://github.com/reqstool/reqstool-python) requirements traceability, with optional [OpenSpec](https://github.com/openspec-dev/openspec) integration.

Provides config-driven skills and commands that let AI coding assistants help you manage requirements, verification cases, and traceability filters.

## Repository Structure

```
reqstool-ai/
├── config/                           # Shared (tool-neutral)
│   └── reqstool-ai.yaml.template     # Project config template
├── openspec/                         # Shared OpenSpec integration
│   ├── reqstool-openspec-conventions.md
│   └── config-rules.yaml
├── reqstool-conventions.md           # Entry point for all conventions
├── reqstool-annotation-conventions.md  # @Requirements/@SVCs annotation placement
├── reqstool-decomposition-conventions.md  # Parent-child hierarchies, dot notation, lifecycle
├── claude/                           # Claude Code integration
│   ├── skills/                       # Claude Code skills
│   │   ├── reqstool-status/
│   │   ├── reqstool-add-req/
│   │   ├── reqstool-add-svc/
│   │   └── reqstool-sync-filters/
│   ├── commands/                     # Claude Code slash commands
│   │   └── reqstool/
│   └── CLAUDE-snippet.md
└── install.sh                        # Installer script
```

## What's Included

### Skills / Commands

| Skill / Command | Description |
|-----------------|-------------|
| `reqstool:status` | Show requirements traceability status for one or all modules |
| `reqstool:add-req` | Add a new requirement and update subproject filters |
| `reqstool:add-svc` | Add a new Software Verification Case and update filters |
| `reqstool:sync-filters` | Sync subproject filters to match system-level IDs |

### Conventions

Installed alongside skills so the AI assistant follows project-wide rules:

| File | Description |
|------|-------------|
| `reqstool-conventions.md` | Entry point — config reference, links to other convention docs |
| `reqstool-annotation-conventions.md` | `@Requirements`/`@SVCs` placement for Java, Python, and TypeScript |
| `reqstool-decomposition-conventions.md` | Parent-child hierarchies, dot notation, lifecycle states |

### OpenSpec Integration (Optional)

| File | Description |
|------|-------------|
| `reqstool-openspec-conventions.md` | Guide for writing spec.md files that reference reqstool |
| `config-rules.yaml` | Rules snippet to merge into `openspec/config.yaml` |
| `CLAUDE-snippet.md` | CLAUDE.md paragraph for OpenSpec + reqstool integration |

## Installation

```bash
# Clone the repo
git clone https://github.com/reqstool/reqstool-ai.git

# Install into your project
./reqstool-ai/install.sh --tool claude /path/to/your-project

# Install with OpenSpec integration
./reqstool-ai/install.sh --tool claude --with-openspec /path/to/your-project
```

The installer:
- Copies skills, commands, and convention files into the tool's config directory (e.g., `.claude/reqstool/`)
- Appends the reqstool section to the tool's instructions file (e.g., `CLAUDE.md`) if not already present
- Creates `.reqstool-ai.yaml` in the project root (config template)
- With `--with-openspec`: copies OpenSpec conventions and merges reqstool rules into `openspec/config.yaml`
- Re-running the installer updates existing files in place

## Configuration

After installing, edit `.reqstool-ai.yaml` in your project root:

```yaml
# .reqstool-ai.yaml
urn: my-project
revision: "0.1.0"
system:
  path: docs/reqstool
modules:
  core:
    path: core/docs/reqstool
    req_prefix: CORE_
    svc_prefix: SVC_CORE_
  app:
    path: app/docs/reqstool
    req_prefix: CLI_
    svc_prefix: SVC_CLI_
```

### Config Reference

| Field | Description |
|-------|-------------|
| `urn` | Project URN used in reqstool YAML files and filter keys |
| `revision` | Version string for new requirements and SVCs |
| `system.path` | Path to the system-level reqstool directory (SSOT) |
| `modules.<name>.path` | Path to a subproject's reqstool directory |
| `modules.<name>.req_prefix` | Requirement ID prefix for this module (e.g., `CORE_`) |
| `modules.<name>.svc_prefix` | SVC ID prefix for this module (e.g., `SVC_CORE_`) |

## How It Works

All skills read `.reqstool-ai.yaml` from the project root at runtime. This config file defines the project URN, module paths, and ID prefixes. No template substitution or build step is needed — the same skill files work across any project with a valid config.

## Prerequisites

- [reqstool](https://github.com/reqstool/reqstool-python) (`pipx install reqstool`)
- [OpenSpec](https://github.com/openspec-dev/openspec) (optional, for spec integration)

### AI Tools

The installer supports multiple AI tool integrations via `--tool <name>`. Currently supported:

| Tool | Flag | Status |
|------|------|--------|
| [Claude Code](https://claude.ai/code) | `--tool claude` (default) | Supported |

Additional tool integrations may be added in the future. Contributions welcome.

## License

Apache 2.0 — see [LICENSE](LICENSE).
