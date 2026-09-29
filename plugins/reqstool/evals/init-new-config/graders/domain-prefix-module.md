---
type: regex
target:
  source: file
  path: .reqstool-ai.yaml
pattern: '^\s+service:\s*\n(?:\s+\S.*\n)*?\s+req_prefix:\s*(?:""|'''')\s*$'
flags: m
weight: 2
---
