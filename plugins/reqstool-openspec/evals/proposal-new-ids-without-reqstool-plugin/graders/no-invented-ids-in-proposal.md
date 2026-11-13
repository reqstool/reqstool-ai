---
type: regex
target:
  source: file
  path: openspec/changes/add-search-limit/proposal.md
pattern: '\b(?!(?:SVC_)?(?:CORE_0001|CORE_0002|CLI_0001|CLI_0001\.1)\b(?!\.\d))(?:SVC_)?[A-Z]+_\d{4}(?:\.\d+)*\b'
match: not_contains
weight: 2
---
