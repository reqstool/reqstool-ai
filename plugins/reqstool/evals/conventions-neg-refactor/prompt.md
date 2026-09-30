---
tags: [conventions, negative]
max_turns: 5
allowed_tools: [Read, Glob, Grep, Skill]
---

Rename `resolve` to `resolve_classpath` in the code below and update its caller. Show me the full updated code.

```python
class ClasspathResolver:
    def resolve(self, project_dir: str) -> list[str]:
        return []


def main(project_dir: str) -> None:
    print(ClasspathResolver().resolve(project_dir))
```
