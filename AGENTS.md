# reqstool-ai

Plugin marketplace (Claude Code and GitHub Copilot CLI) for reqstool AI-assisted requirements traceability.

## Versioning

When changing a plugin, bump **both** versions so installed instances detect the update:

1. **Plugin version** — `plugins/<plugin>/.claude-plugin/plugin.json` → `"version"` field
2. **Marketplace version** — `.claude-plugin/marketplace.json` → `metadata.version` field
3. **Template version** — bump the `// @reqstool-openspec-hooks: X.Y.Z` header in `plugins/reqstool-openspec/skills/init/references/openspecui.hooks.ts` on any change to that file

Use semver: patch for docs/typo fixes, minor for new features or behavior changes, major for breaking changes.

Both Claude Code and GitHub Copilot read `.claude-plugin/marketplace.json`.

## Plugins

- `plugins/reqstool/` — core reqstool skills and commands
- `plugins/reqstool-openspec/` — OpenSpec integration (separate install)

## Testing plugins locally

```bash
# Load plugins directly (session-scoped, no side effects)
claude --plugin-dir ./plugins/reqstool
claude --plugin-dir ./plugins/reqstool-openspec

# Or for Copilot CLI
copilot --plugin-dir ./plugins/reqstool
copilot --plugin-dir ./plugins/reqstool-openspec
```

## Plugin evals

The repository holds no Anthropic API key; never add an `ANTHROPIC_API_KEY` repository secret. Run the *Plugin Evals* workflow with `.github/scripts/run-plugin-evals.sh`, which sets the key as a `plugin-evals` environment secret for that one run and deletes it afterwards. See [CONTRIBUTING.md](CONTRIBUTING.md#evals).

## Pre-commit checks

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full testing and contribution process.
