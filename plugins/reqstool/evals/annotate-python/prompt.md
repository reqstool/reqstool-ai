---
tags: [conventions, annotations]
max_turns: 10
allowed_tools: [Read, Glob, Grep, Skill]
---

We use reqstool for traceability. In the code below, `resolve` implements requirement CORE_0002 and `test_resolves_maven_project` verifies SVC_CORE_0002. Add the reqstool annotations and show me the full updated code for both files.

```python
# src/acme/classpath.py
class ClasspathResolver:
    def __init__(self, cache_dir: str):
        self.cache_dir = cache_dir

    def resolve(self, project_dir: str) -> list[str]:
        ...

    def _read_pom(self, project_dir: str) -> str:
        ...
```

```python
# tests/test_classpath.py
from acme.classpath import ClasspathResolver

class TestClasspathResolver:
    def test_resolves_maven_project(self, tmp_path):
        ...
```
