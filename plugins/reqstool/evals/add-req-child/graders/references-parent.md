---
type: regex
target:
  source: file
  path: docs/reqstool/requirements.yml
pattern: 'id: CORE_0002\.1(?:(?!\n\s*- id:)[\s\S])*?references:\s*\n\s*requirement_ids:\s*\[\s*"?CORE_0002"?\s*\]'
---
