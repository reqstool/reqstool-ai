#!/usr/bin/env bash
# Seed the workspace with the shared acme-recipes fixture project.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes/." .
# Install the plugin's current hook template.
cp "$(dirname "$0")"/../../skills/init/references/openspecui.hooks.ts openspec/openspecui.hooks.ts
