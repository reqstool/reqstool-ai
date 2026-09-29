---
tags: [add-svc, decomposition]
max_turns: 25
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit]
---

CLI_0001.1 (text output) already has one verification case. Add a second automated-test SVC for it covering the empty case: when no recipes match, the text output says "No recipes found". Don't ask me to confirm, just make the change.
