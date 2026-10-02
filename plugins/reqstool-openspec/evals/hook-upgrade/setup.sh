#!/usr/bin/env bash
# Seed the workspace with the shared acme-recipes fixture project.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes/." .
# Install the current template with an older version marker so the skill offers an upgrade.
sed '1s/^\/\/ @reqstool-openspec-hooks: .*/\/\/ @reqstool-openspec-hooks: 0.0.1/' "$(dirname "$0")"/../../skills/init/references/openspecui.hooks.ts > openspec/openspecui.hooks.ts
