---
type: regex
target:
  source: file
  path: .reqstool-ai.yaml
pattern: '^\s+svc_prefix:\s*["'']?SVC_["'']?\s*(?:#.*)?$'
flags: m
---
