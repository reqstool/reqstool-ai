---
tags: [conventions, annotations]
max_turns: 10
allowed_tools: [Read, Glob, Grep, Skill]
---

We use reqstool for traceability. In the code below, `resolveClasspath` implements requirements CORE_0001 and CORE_0002, and the "resolves a Maven project" test verifies SVC_CORE_0002. Add the reqstool annotations and show me the full updated code for both files.

```typescript
// src/classpath.ts
export class ClasspathResolver {
  constructor(private readonly cacheDir: string) {}

  resolveClasspath(projectDir: string): string[] {
    return [];
  }

  private readPom(projectDir: string): string {
    return "";
  }
}
```

```typescript
// test/classpath.test.ts
import { describe, expect, test } from "vitest";
import { ClasspathResolver } from "../src/classpath";

describe("ClasspathResolver", () => {
  test("resolves a Maven project", () => {
    expect(new ClasspathResolver("/tmp").resolveClasspath("fixtures/maven")).toEqual([]);
  });
});
```
