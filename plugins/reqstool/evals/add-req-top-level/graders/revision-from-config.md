---
type: regex
target:
  source: file
  path: docs/reqstool/requirements.yml
pattern: 'id: CORE_0003(?:(?!\n\s*- id:)[\s\S])*?revision: "?0\.2\.0"?'
---
