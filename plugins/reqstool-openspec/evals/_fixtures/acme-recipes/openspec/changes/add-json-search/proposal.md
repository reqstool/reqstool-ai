## Why

Scripts that consume `acme search` need machine-readable output; today it only prints text.

## What Changes

- Add `--format json|text` to `acme search` (default `text`).

## Impact

- Affected reqstool requirements: CLI_0001, CLI_0001.1
- Affected code: `cli/src/main/java/acme/cli/SearchCommand.java`
