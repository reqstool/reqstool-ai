---
type: regex
target:
  source: file
  path: openspec/openspecui.hooks.ts
pattern: '^// @reqstool-openspec-hooks: 0\.0\.1\b'
match: 'not_contains'
weight: 2
---
