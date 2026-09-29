#!/usr/bin/env bash
# Seed the workspace with the fresh fixture: no SVCs anywhere to copy the format from.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes-fresh/." .
