---
type: regex
target:
  source: file
  path: openspec/changes/add-json-search/specs/recipe-search/spec.md
pattern: '\bGIVEN\b|\bWHEN\b(?!\*\* SVC_[\w.]+ is run)|\bTHEN\b(?!\*\* it passes)|human-readable'
match: not_contains
weight: 2
---
