---
type: regex
target:
  source: file
  path: openspec/changes/add-gradle-support/specs/classpath/spec.md
pattern: '\bGIVEN\b|\bWHEN\b(?!\*\* SVC_[\w.]+ is run)|\bTHEN\b(?!\*\* it passes)|Maven|Gradle projects'
match: 'not_contains'
weight: 2
---
