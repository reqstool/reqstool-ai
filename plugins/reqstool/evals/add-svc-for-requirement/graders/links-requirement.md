---
type: regex
target:
  source: file
  path: docs/reqstool/software_verification_cases.yml
pattern: 'id: SVC_CORE_0002(?:(?!\n\s*- id:)[\s\S])*?requirement_ids:\s*\[\s*"?CORE_0002"?\s*\]'
---
