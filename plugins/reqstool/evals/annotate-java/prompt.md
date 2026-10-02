---
tags: [conventions, annotations]
max_turns: 10
allowed_tools: [Read, Glob, Grep, Skill]
---

We use reqstool for traceability. In the code below, `resolveClasspath` implements requirement CORE_0002 and `resolvesMavenProject` verifies SVC_CORE_0002. Add the reqstool annotations and show me the full updated code for both files.

```java
// src/main/java/com/acme/ClasspathResolver.java
package com.acme;

import java.nio.file.Path;
import java.util.List;

public class ClasspathResolver {
    public List<Path> resolveClasspath(Path projectDir) {
        return List.of();
    }
}
```

```java
// src/test/java/com/acme/ClasspathResolverTest.java
package com.acme;

import org.junit.jupiter.api.Test;
import java.nio.file.Path;
import static org.junit.jupiter.api.Assertions.assertTrue;

class ClasspathResolverTest {
    @Test
    void resolvesMavenProject() {
        assertTrue(new ClasspathResolver().resolveClasspath(Path.of("fixtures/maven")).isEmpty());
    }
}
```
