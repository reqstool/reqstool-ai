---
type: regex
target:
  source: file
  path: openspec/changes/add-json-search/specs/recipe-search/spec.md
pattern: '^(?=[\s\S]*#### Scenario: SVC_CLI_0001[ \t]*\n+- \*\*WHEN\*\* SVC_CLI_0001 is run[ \t]*\n- \*\*THEN\*\* it passes[ \t]*$)(?=[\s\S]*#### Scenario: SVC_CLI_0001\.1[ \t]*\n+- \*\*WHEN\*\* SVC_CLI_0001\.1 is run[ \t]*\n- \*\*THEN\*\* it passes[ \t]*$)'
weight: 2
flags: m
---
