# reqstool Build & Test Runner Configuration Conventions

reqstool maps `<testcase name="...">` entries in JUnit XML test reports to
`@SVCs`-annotated test methods. If a test runner writes a name that doesn't include
the method name, reqstool can't make that link.

This doc currently covers **Gradle + JUnit 5**. Maven Surefire is unaffected — it
always embeds the method name regardless of display-name settings.

## Gradle + JUnit 5 Parameterized Tests

### Symptom

Gradle's JUnit XML reporter writes parameterized `@Test` case names using the
display name, which defaults to `[N] arguments` — a format that omits the method
name. When reqstool processes the JUnit XML test results (e.g. via
`reqstool status`), this produces warnings like:

```
Skipping parameterized test case with display-name-only format (method name not
recoverable): '[1] ACTIVE' in <test-result-file>
```

and the corresponding `@SVCs` IDs are never marked as verified.

### Fix

Configure JUnit 5 to include the method name in the display name by setting the
`junit.jupiter.params.displayname.default` system property on all test tasks
(unit, integration, e2e):

```kotlin
// Kotlin DSL (build.gradle.kts)
tasks.withType<Test>().configureEach {
    systemProperty("junit.jupiter.params.displayname.default", "{displayName}[{index}]")
}
```

```groovy
// Groovy DSL (build.gradle)
tasks.withType(Test).configureEach {
    systemProperty 'junit.jupiter.params.displayname.default', '{displayName}[{index}]'
}
```

This produces test case names like `checkStatus(StatusType)[1]` instead of
`[1] ACTIVE`, which reqstool can parse to recover the method name and link the
result to its `@SVCs` annotation.

> **Explicit `name=` overrides this:** tests using `@ParameterizedTest(name = "{index} ...")`
> still omit the method name, because the explicit `name` overrides the
> `systemProperty` default. Either remove the custom `name` or change it to begin
> with `{displayName}`: `@ParameterizedTest(name = "{displayName}[{index}] ...")`.

## References

- [reqstool-java-gradle-plugin PR #63](https://github.com/reqstool/reqstool-java-gradle-plugin/pull/63)
  documents this fix (open at time of writing)
- [reqstool-client PR #405](https://github.com/reqstool/reqstool-client/pull/405) —
  parser-side handling for Gradle parameterized test names
