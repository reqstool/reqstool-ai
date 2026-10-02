---
tags: [add-req]
max_turns: 25
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit]
---

Add two requirements to the core module. First: the tool should cache resolved classpaths between runs ("Classpath Caching", should, performance-efficiency). Second: the tool may resolve classpaths offline when a cache is present ("Offline Resolution", may, reliability). These are the final values — don't ask me to confirm.
