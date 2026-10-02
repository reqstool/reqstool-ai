---
type: regex
target:
  source: file
  path: openspec/changes/add-gradle-support/specs/classpath/spec.md
pattern: '\b(?:GIVEN|WHEN|THEN)\b|Maven|Gradle projects'
match: 'not_contains'
weight: 2
---
