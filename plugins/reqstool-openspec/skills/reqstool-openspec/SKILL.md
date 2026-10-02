---
name: reqstool-openspec
description: Conventions for referencing reqstool requirement and SVC IDs in OpenSpec documents. Use only when an OpenSpec spec.md, proposal or tasks.md references reqstool IDs (such as CORE_0001 or SVC_CORE_0001) or the project has a .reqstool-ai.yaml; not for OpenSpec work in projects without reqstool.
license: Apache-2.0
allowed-tools: Read, Grep, Glob
metadata:
  author: reqstool-ai
  version: "1.0"
---

When creating or modifying OpenSpec spec.md files that reference reqstool requirements or SVCs,
read the convention files from this skill's references/ directory.

- `references/reqstool-openspec-conventions.md` — how to reference reqstool IDs in spec.md files, format rules, validation
- `references/config-rules.yaml` — reqstool rules to add to openspec/config.yaml

If `openspec/openspecui.hooks.ts` does not exist in the project root, proactively suggest:
> Run `/reqstool-openspec:init` to install the reqstool openspecui hook, which automatically enriches all OpenSpec documents with requirement and SVC titles at read time.
