---
tags: [conventions, decomposition]
max_turns: 10
allowed_tools: [Read, Glob, Grep, Skill]
---

We use reqstool. One of our requirements is:

```yaml
  - id: CLI_0004
    title: Report Export
    significance: shall
    description: The tool shall export traceability reports as PDF, HTML and CSV
    categories: [functional-suitability]
    revision: 0.1.0
```

CSV ships in 0.2.0, HTML and PDF later, and each format needs its own tests. Should I split this requirement? If yes, give me the requirements YAML and tell me which SVC IDs I'll need.
