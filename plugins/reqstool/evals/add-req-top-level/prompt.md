---
tags: [add-req]
max_turns: 25
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit]
---

Add a new requirement to the core module: the tool should cache resolved classpaths between runs, so repeated invocations on an unchanged project skip resolution. Title it "Classpath Caching", significance should, category performance-efficiency. These are the final values — don't ask me to confirm, just make the change.
