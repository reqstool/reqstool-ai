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

# Install the plugin
/plugin install reqstool@reqstool-ai --scope project
```

### GitHub Copilot CLI

```bash
# Add marketplace (one-time)
copilot plugin marketplace add reqstool/reqstool-ai

# Install the plugin
copilot plugin install reqstool@reqstool-ai
```

### Post-install configuration

Copy the config template to your project root and edit it:

```bash
cp <plugin-cache-path>/config/reqstool-ai.yaml.template .reqstool-ai.yaml
```

Edit `.reqstool-ai.yaml` with your project's URN, paths, and module prefixes. See the [documentation](https://reqstool.github.io) for the full config reference.

## Skills and commands

### Commands (user-invoked)

| Command | Description |
|---------|-------------|
| `/reqstool:add-req` | Add a new requirement and update subproject filters |
| `/reqstool:add-svc` | Add a new Software Verification Case and update filters |
| `/reqstool:status` | Show requirements traceability status for one or all modules |
| `/reqstool:sync-filters` | Sync subproject filters to match system-level IDs |

### Skills (auto-applied)

| When you're... | Skill |
|---|---|
| Working with reqstool YAML files or annotations | `reqstool-conventions` |
| Working with OpenSpec spec.md files | `reqstool-openspec` |

Skills are applied automatically based on context — no manual invocation needed.

## Plugin details

### reqstool-conventions

Bundled convention docs that are auto-applied when working with reqstool files:

- **reqstool-conventions.md** — overview of config fields and skill conventions
- **reqstool-annotation-conventions.md** — `@Requirements` and `@SVCs` placement rules (Java, Python, TypeScript)
- **reqstool-decomposition-conventions.md** — parent-child hierarchies, dot-notation IDs, lifecycle states

### reqstool-openspec

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
│   └── reqstool/                     # Plugin (shared by both tools)
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── skills/
│       │   ├── reqstool-add-req/
│       │   ├── reqstool-add-svc/
│       │   ├── reqstool-status/
│       │   ├── reqstool-sync-filters/
│       │   ├── reqstool-conventions/
│       │   │   ├── SKILL.md
│       │   │   └── references/       # Bundled convention docs
│       │   └── reqstool-openspec/
│       │       ├── SKILL.md
│       │       └── references/       # Bundled OpenSpec docs
│       └── commands/
│           └── reqstool/
├── config/
│   └── reqstool-ai.yaml.template
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

# Copilot CLI
copilot plugin install --path ./plugins/reqstool
```

## Updating

```bash
# Claude Code
/plugin update reqstool@reqstool-ai

# Copilot CLI
copilot plugin update reqstool@reqstool-ai
```

## Contributing

See the organization-wide [CONTRIBUTING.md](https://github.com/reqstool/.github/blob/main/CONTRIBUTING.md).

### Adding or updating plugin content

1. Make your changes in `plugins/reqstool/skills/` or `plugins/reqstool/commands/`.
2. Bump the version in `plugins/reqstool/.claude-plugin/plugin.json`.
3. Bump `metadata.version` in both `.claude-plugin/marketplace.json` and `.github/plugin/marketplace.json`.
4. Test locally with `claude --plugin-dir ./plugins/reqstool`.
5. Submit a PR.

## Documentation

Full documentation can be found [here](https://reqstool.github.io).

## License

Apache 2.0 -- see [LICENSE](LICENSE).
