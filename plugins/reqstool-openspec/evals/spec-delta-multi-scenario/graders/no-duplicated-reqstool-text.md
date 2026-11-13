---
type: regex
target:
  source: file
  path: openspec/changes/add-gradle-support/specs/classpath/spec.md
pattern: '^(?!- \*\*WHEN\*\* SVC_[\w.]+ is run[ \t]*$|- \*\*THEN\*\* it passes[ \t]*$).*\b(?:WHEN|THEN)\b|\bGIVEN\b|\bAND\b|Maven|Gradle projects'
match: 'not_contains'
weight: 2
flags: m
---
