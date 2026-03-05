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

### Claude Code

```bash
# Clone the repo
git clone https://github.com/reqstool/reqstool-ai.git

# Install reqstool skills only
./reqstool-ai/install.sh /path/to/your-project

# Install with OpenSpec integration
./reqstool-ai/install.sh --with-openspec /path/to/your-project
```

The installer:
- Copies skills to `.claude/skills/reqstool-*/`
- Copies commands to `.claude/commands/reqstool/`
- Copies convention files to `.claude/` (annotation, decomposition, entry-point)
- Creates `.reqstool-ai.yaml` in the project root (config template)
- With `--with-openspec`: copies OpenSpec conventions file and prints setup instructions
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

## OpenSpec Setup

If installed with `--with-openspec`, complete these manual steps:

1. **Add to CLAUDE.md** — copy the snippet from `claude/CLAUDE-snippet.md` into your project's `CLAUDE.md`
2. **Add rules to openspec/config.yaml** — merge the rules from `openspec/config-rules.yaml` into your `openspec/config.yaml` under the `rules:` key

## How It Works

All skills read `.reqstool-ai.yaml` from the project root at runtime. This config file defines the project URN, module paths, and ID prefixes. No template substitution or build step is needed — the same skill files work across any project with a valid config.

## Prerequisites

- [reqstool](https://github.com/reqstool/reqstool-python) (`pipx install reqstool`)
- [Claude Code](https://claude.ai/code)
- [OpenSpec](https://github.com/openspec-dev/openspec) (optional, for spec integration)

## License

Apache 2.0 — see [LICENSE](LICENSE).
