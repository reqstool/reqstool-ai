---
type: regex
target:
  source: file
  path: docs/reqstool/software_verification_cases.yml
pattern: 'id: SVC_CLI_0001\.1a(?:(?!\n\s*- id:)[\s\S])*?requirement_ids:\s*\[\s*"?CLI_0001\.1"?\s*\]'
---
