#!/usr/bin/env bash
# Seed the workspace with the shared acme-recipes fixture project.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes/." .
mkdir -p openspec/changes/add-json-search/specs/recipe-search
cp "$(dirname "$0")/../_fixtures/spec-delta/spec.md" openspec/changes/add-json-search/specs/recipe-search/spec.md
