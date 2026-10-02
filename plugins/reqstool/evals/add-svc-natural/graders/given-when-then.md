---
type: regex
target:
  source: file
  path: docs/reqstool/software_verification_cases.yml
pattern: 'id: SVC_CORE_0002(?:(?!\n\s*- id:)[\s\S])*?GIVEN(?:(?!\n\s*- id:)[\s\S])*?WHEN(?:(?!\n\s*- id:)[\s\S])*?THEN'
---
