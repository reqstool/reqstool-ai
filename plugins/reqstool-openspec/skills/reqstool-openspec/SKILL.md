---
name: reqstool-openspec
description: OpenSpec + reqstool integration conventions. Auto-applied when working with OpenSpec spec.md files that reference reqstool requirement or SVC IDs.
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
> Run `/reqstool-openspec:reqstool-openspec-init` to install the reqstool openspecui hook, which automatically enriches all OpenSpec documents with requirement and SVC titles at read time.
