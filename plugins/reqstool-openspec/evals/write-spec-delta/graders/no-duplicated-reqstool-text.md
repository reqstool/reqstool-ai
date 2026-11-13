---
type: regex
target:
  source: file
  path: openspec/changes/add-json-search/specs/recipe-search/spec.md
pattern: '^(?!- \*\*WHEN\*\* SVC_[\w.]+ is run[ \t]*$|- \*\*THEN\*\* it passes[ \t]*$).*\b(?:WHEN|THEN)\b|\bGIVEN\b|\bAND\b|human-readable'
match: not_contains
weight: 2
flags: m
---
