---
type: regex
target:
  source: file
  path: openspec/changes/add-dark-mode/specs/ui/spec.md
pattern: '\b(?:SVC_)?[A-Z]+_\d{4}\b'
match: 'not_contains'
---
