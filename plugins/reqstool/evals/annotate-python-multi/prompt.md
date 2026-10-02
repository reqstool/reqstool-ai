---
tags: [conventions, annotations]
max_turns: 10
allowed_tools: [Read, Glob, Grep, Skill]
---

We use reqstool for traceability. `discover_and_filter` implements both CORE_0001 and CORE_0002, and `test_discovers_from_maven_project` verifies SVC_CORE_0001. Add the reqstool decorators and show me the full updated code for both files.

```python
# src/acme/discovery.py
def discover_and_filter(project_dir: str, keyword: str) -> list[str]:
    ...
```

```python
# tests/test_discovery.py
from acme.discovery import discover_and_filter

def test_discovers_from_maven_project(tmp_path):
    assert discover_and_filter(str(tmp_path), "") == []
```
