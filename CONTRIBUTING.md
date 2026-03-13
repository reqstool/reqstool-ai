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

Test the plugins locally:

```bash
# Claude Code
claude --plugin-dir ./plugins/reqstool
claude --plugin-dir ./plugins/reqstool-openspec

# Copilot CLI
copilot plugin install --path ./plugins/reqstool
copilot plugin install --path ./plugins/reqstool-openspec
```

## Adding or updating plugin content

1. Make your changes in `plugins/reqstool/` or `plugins/reqstool-openspec/`.
2. Bump the version in the changed plugin's `.claude-plugin/plugin.json`.
3. Bump `metadata.version` in both `.claude-plugin/marketplace.json` and `.github/plugin/marketplace.json`.
4. Test locally.
5. Submit a PR.
