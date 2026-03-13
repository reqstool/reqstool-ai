---
name: reqstool-conventions
description: reqstool conventions for requirements, annotations, and decomposition. Auto-applied when working with reqstool YAML files (requirements.yml, software_verification_cases.yml), @Requirements/@SVCs annotations, or .reqstool-ai.yaml.
license: Apache-2.0
allowed-tools: Read, Grep, Glob
metadata:
  author: reqstool-ai
  version: "1.0"
---

When working with reqstool requirements, SVCs, annotations, or filters, read the relevant
convention files from this skill's references/ directory before making changes.

- `references/reqstool-conventions.md` — overview of config fields, skill conventions, and pointers to the other docs
- `references/reqstool-annotation-conventions.md` — where and how to place `@Requirements` and `@SVCs` annotations (Java, Python, TypeScript)
- `references/reqstool-decomposition-conventions.md` — parent-child requirement hierarchies, dot-notation IDs, lifecycle states, prefix strategies
