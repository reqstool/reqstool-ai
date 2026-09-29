---
tags: [add-req, decomposition]
max_turns: 25
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit]
---

Classpath resolution (CORE_0002) needs a more specific requirement for Gradle. Add it as a sub-requirement of CORE_0002: the tool shall resolve the classpath of Gradle projects through the Gradle Tooling API. Title "Classpath Resolution — Gradle", significance shall, category compatibility. These are the final values — don't ask me to confirm, just make the change.
