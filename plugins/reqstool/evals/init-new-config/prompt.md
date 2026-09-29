---
tags: [init]
max_turns: 25
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit]
---

Set up reqstool-ai for this repository. URN is payments-svc, revision 1.0.0, and the system-level reqstool files go in docs/reqstool. There is a single module called service, also at docs/reqstool; it uses several domain-specific prefixes (AUTH_, API_, CORE_) whose IDs we manage by hand. Skip the MCP server setup. These are the final values — don't ask me to confirm, just write the config.
