---
type: regex
target:
  source: file
  path: core/docs/reqstool/software_verification_cases.yml
pattern: 'svc_ids:\s*\n\s*includes:\s*(?:\[[^\]]*\bSVC_CORE_0002\b|\n\s*-\s*"?SVC_CORE_0002\b)'
weight: 2
---
