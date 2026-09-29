#!/usr/bin/env bash
# Seed the workspace with the fresh fixture: no child requirements or SVCs to copy from.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes-fresh/." .
