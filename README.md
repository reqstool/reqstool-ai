[![Commit Activity](https://img.shields.io/github/commit-activity/m/reqstool/reqstool-ai?label=commits&style=for-the-badge)](https://github.com/reqstool/reqstool-ai/pulse)
[![GitHub Issues](https://img.shields.io/github/issues/reqstool/reqstool-ai?style=for-the-badge&logo=github)](https://github.com/reqstool/reqstool-ai/issues)
[![License](https://img.shields.io/github/license/reqstool/reqstool-ai?style=for-the-badge&logo=opensourceinitiative)](https://opensource.org/license/mit/)
[![Documentation](https://img.shields.io/badge/Documentation-blue?style=for-the-badge&link=docs)](https://reqstool.github.io)

# Reqstool AI Integration

AI-assisted management of [reqstool](https://github.com/reqstool/reqstool-client) requirements traceability, with optional [OpenSpec](https://github.com/openspec-dev/openspec) integration.

Provides config-driven skills and commands that let AI coding assistants help you manage requirements, verification cases, and traceability filters.

## Installation

```bash
# Clone the repo
git clone https://github.com/reqstool/reqstool-ai.git

# Install into your project
./reqstool-ai/install.sh --tool claude /path/to/your-project

# Install with OpenSpec integration
./reqstool-ai/install.sh --tool claude --with-openspec /path/to/your-project
```

## Skills

| Skill / Command | Description |
|-----------------|-------------|
| `reqstool:status` | Show requirements traceability status for one or all modules |
| `reqstool:add-req` | Add a new requirement and update subproject filters |
| `reqstool:add-svc` | Add a new Software Verification Case and update filters |
| `reqstool:sync-filters` | Sync subproject filters to match system-level IDs |

## Configuration

Edit `.reqstool-ai.yaml` in your project root after installation. See the [documentation](https://reqstool.github.io) for the full config reference.

## Prerequisites

- [reqstool CLI](https://github.com/reqstool/reqstool-client) (`pipx install reqstool`)
- [OpenSpec](https://github.com/openspec-dev/openspec) (optional)

## Documentation

Full documentation can be found [here](https://reqstool.github.io).

## Contributing

See the organization-wide [CONTRIBUTING.md](https://github.com/reqstool/.github/blob/main/CONTRIBUTING.md).

## License

Apache 2.0 -- see [LICENSE](LICENSE).
