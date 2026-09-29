---
type: regex
target:
  source: file
  path: docs/reqstool/requirements.yml
pattern: 'id: CLI_0001\.2(?:(?!\n\s*- id:)[\s\S])*?references:\s*\n\s*requirement_ids:\s*\[\s*"?CLI_0001"?\s*\]'
---
