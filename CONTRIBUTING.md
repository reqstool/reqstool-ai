# Contributing to reqstool-ai

Thank you for your interest in contributing!

For DCO sign-off, commit conventions, and code review process, see the organization-wide [CONTRIBUTING.md](https://github.com/reqstool/.github/blob/main/CONTRIBUTING.md).

## Prerequisites

- [reqstool CLI](https://github.com/reqstool/reqstool-client)
- Claude Code or GitHub Copilot CLI (for testing plugins)

## Setup

```bash
git clone https://github.com/reqstool/reqstool-ai.git
cd reqstool-ai
```

## Testing

Test the plugin locally:

```bash
# Claude Code
claude --plugin-dir ./plugins/reqstool

# Copilot CLI
copilot plugin install --path ./plugins/reqstool
```

## Adding or updating plugin content

1. Make your changes in `plugins/reqstool/skills/` or `plugins/reqstool/commands/`.
2. Bump the version in `plugins/reqstool/.claude-plugin/plugin.json`.
3. Bump `metadata.version` in both `.claude-plugin/marketplace.json` and `.github/plugin/marketplace.json`.
4. Test locally.
5. Submit a PR.
