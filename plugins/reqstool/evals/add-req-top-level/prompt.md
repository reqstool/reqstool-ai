---
tags: [add-req]
max_turns: 25
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit]
---

We keep re-resolving the classpath on every run even when nothing changed. Can you add a requirement for the core module that the tool caches resolved classpaths between runs? It's a nice-to-have performance thing, not a must.
