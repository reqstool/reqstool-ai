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
copilot --plugin-dir ./plugins/reqstool
copilot --plugin-dir ./plugins/reqstool-openspec
```

### Evals

Each plugin has an eval suite under `plugins/<plugin>/evals/` that scores its skills against a no-plugin baseline with [`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals). Cases seed their workspace from `evals/_fixtures/` with a scaffold script, so `--scaffold` is required, and the file-editing skills need `Write` and `Edit` granted:

```bash
claude plugin eval plugins/reqstool --scaffold --allow-tools Write Edit --threshold 0.9
claude plugin eval plugins/reqstool-openspec --scaffold --allow-tools Write Edit --threshold 0.9

# Iterate on one case, one run, no baseline arm
claude plugin eval plugins/reqstool --scaffold --allow-tools Write Edit --case add-req-child --runs 1 --ablation none
```

Evals run locally only: there is no CI workflow for them, and the repository holds no API key. Runs count against your Claude plan's usage, or are billed if you are logged in with an API key.

Each case runs 3 times by default. `--threshold 0.9` fails a case when a grader fails in every run but tolerates a single miss in one run, as long as a case's scored grader weights add up to at most 9.

When you change a skill, run its cases; when you add a skill, add a case with a `skill-fired` grader and at least one grader on what the skill produces.

## Adding or updating plugin content

1. Make your changes in `plugins/reqstool/` or `plugins/reqstool-openspec/`.
2. Bump the version in the changed plugin's `.claude-plugin/plugin.json`.
3. Bump `metadata.version` in `.claude-plugin/marketplace.json`.
4. Test locally.
5. Submit a PR.
