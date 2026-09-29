---
type: regex
target:
  source: file
  path: openspec/changes/add-json-search/specs/recipe-search/spec.md
pattern: '\b(?:GIVEN|WHEN|THEN)\b|human-readable'
match: not_contains
weight: 2
---
