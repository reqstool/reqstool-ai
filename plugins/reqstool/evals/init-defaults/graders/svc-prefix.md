---
type: regex
target:
  source: file
  path: .reqstool-ai.yaml
pattern: 'svc_prefix:\s*["'']?SVC_PARSER_["'']?\s*$'
flags: m
weight: 2
---
