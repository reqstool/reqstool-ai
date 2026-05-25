# reqstool-ai

Claude Code plugin marketplace for reqstool AI-assisted requirements traceability.

## Versioning

When changing a plugin, bump **both** versions so installed instances detect the update:

1. **Plugin version** — `plugins/<plugin>/.claude-plugin/plugin.json` → `"version"` field
2. **Marketplace version** — `.claude-plugin/marketplace.json` and `.github/plugin/marketplace.json` → `metadata.version` field
3. **Template version** — bump the `// @reqstool-openspec-hooks: X.Y.Z` header in `plugins/reqstool-openspec/skills/reqstool-openspec-init/references/openspecui.hooks.ts` on any change to that file

Use semver: patch for docs/typo fixes, minor for new features or behavior changes, major for breaking changes.

Keep both marketplace.json files in sync (`.claude-plugin/` for Claude Code, `.github/plugin/` for Copilot CLI).

## Plugins

- `plugins/reqstool/` — core reqstool skills and commands
- `plugins/reqstool-openspec/` — OpenSpec integration (separate install)

## Testing plugins locally

```bash
# Load plugins directly (session-scoped, no side effects)
claude --plugin-dir ./plugins/reqstool
claude --plugin-dir ./plugins/reqstool-openspec

# Or for Copilot CLI
copilot plugin install --path ./plugins/reqstool
copilot plugin install --path ./plugins/reqstool-openspec
```

## Pre-commit checks

See [CONTRIBUTING.md](CONTRIBUTING.md) for the full testing and contribution process.
