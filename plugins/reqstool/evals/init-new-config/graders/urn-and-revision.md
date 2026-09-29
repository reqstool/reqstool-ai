---
type: regex
target:
  source: file
  path: .reqstool-ai.yaml
pattern: '^urn:\s*"?payments-svc"?\s*$[\s\S]*^revision:\s*"?1\.0\.0"?\s*$|^revision:\s*"?1\.0\.0"?\s*$[\s\S]*^urn:\s*"?payments-svc"?\s*$'
flags: m
---
