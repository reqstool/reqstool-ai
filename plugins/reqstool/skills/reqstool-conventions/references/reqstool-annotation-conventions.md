# reqstool Annotation Conventions

## Terminology

Throughout reqstool documentation, **"annotations"** is used as the umbrella term for
language-specific metadata that links code to requirements:

| Language   | Mechanism        | Syntax |
|------------|------------------|--------|
| Java       | Annotations      | `@Requirements({"ID"})` / `@SVCs({"ID"})` |
| Python     | Decorators       | `@requirements(["ID"])` / `@svcs(["ID"])` |
| TypeScript | JSDoc tags       | `/** @requirements ID */` / `/** @svcs ID */` |

When you see "add annotations" in conventions or task lists, use the appropriate
mechanism for your language.

## Principle: As Close to the Implementation as Possible

Place `@Requirements` and `@SVCs` annotations **on the method or function that directly
implements or verifies the requirement** — not on the class or module.

This applies across languages. The exact granularity depends on what the language supports:

| Language   | `@Requirements` placement | `@SVCs` placement |
|------------|---------------------------|-------------------|
| Java       | On the implementing method | On the test method |
| Python     | On the implementing function (decorator) | On the test function (decorator) |
| TypeScript | JSDoc tag on the implementing function | JSDoc tag on the test function/block |

## Why Method Level?

- **Precise traceability**: each annotation maps to the exact code that fulfills the requirement
- **Easier auditing**: reviewers can verify implementation by reading one method, not an entire class
- **Refactoring safety**: if a method moves to another class, the annotation moves with it

## Java Examples

### `@Requirements` — on the implementation method

```java
import io.github.reqstool.annotations.Requirements;

public class RecipeDiscoveryEngine {

    @Requirements({"CORE_0001"})
    public List<Recipe> discoverRecipes(Path projectDir) {
        // implementation
    }

    @Requirements({"CORE_0005"})
    public ClasspathResult resolveClasspath(Path projectDir) {
        // implementation
    }
}
```

### `@SVCs` — on the test method

```java
import io.github.reqstool.annotations.SVCs;

class RecipeDiscoveryEngineTest {

    @Test
    @SVCs({"SVC_CORE_0001"})
    void discoverRecipes_returnsAvailableRecipes() {
        // GIVEN a project with OpenRewrite on the classpath
        // WHEN discoverRecipes is called
        // THEN available recipes are returned
    }

    @Test
    @SVCs({"SVC_CORE_0005"})
    void resolveClasspath_handlesMavenProject() {
        // GIVEN a Maven project directory
        // WHEN resolveClasspath is called
        // THEN the classpath is resolved successfully
    }
}
```

### Avoid: class-level annotations

```java
// BAD — too coarse, hard to tell which method implements which requirement
@Requirements({"CORE_0001", "CORE_0005"})
public class RecipeDiscoveryEngine {
    // ...
}
```

> **Exception — parent SVCs for decomposed requirements:** When a requirement is
> decomposed into a parent-child hierarchy, placing the parent `@SVCs` at class level
> is acceptable. See `reqstool-decomposition-conventions.md`.

## Python Examples

### `@Requirements` — on the implementation function

```python
from reqstool_python_decorators.decorators.decorators import Requirements

class RecipeDiscoveryEngine:

    @Requirements("CORE_0001")
    def discover_recipes(self, project_dir: str) -> list:
        # implementation
        ...

    @Requirements("CORE_0005")
    def resolve_classpath(self, project_dir: str):
        # implementation
        ...
```

Multiple requirements use variadic args (not an array):

```python
@Requirements("CORE_0001", "CORE_0002")
def discover_and_filter_recipes(self, project_dir: str) -> list:
    ...
```

### `@SVCs` — on the test function

```python
from reqstool_python_decorators.decorators.decorators import SVCs

class TestRecipeDiscoveryEngine:

    @SVCs("SVC_CORE_0001")
    def test_discover_recipes_returns_available_recipes(self):
        # GIVEN a project with recipes on the classpath
        # WHEN discover_recipes is called
        # THEN available recipes are returned
        ...

    @SVCs("SVC_CORE_0005")
    def test_resolve_classpath_handles_maven_project(self):
        # GIVEN a Maven project directory
        # WHEN resolve_classpath is called
        # THEN the classpath is resolved successfully
        ...
```

### Avoid: class-level decorators

```python
# BAD — too coarse
@Requirements("CORE_0001", "CORE_0005")
class RecipeDiscoveryEngine:
    ...
```

## TypeScript Examples

TypeScript annotations use JSDoc tags processed by the CLI at build time.
There are no runtime imports — install `@reqstool/reqstool-typescript-tags` as a dev dependency.

### `@Requirements` — JSDoc tag on the implementation function

```typescript
/** @Requirements CORE_0001 */
function discoverRecipes(projectDir: string): Recipe[] {
    // implementation
}

/** @Requirements CORE_0005 */
function resolveClasspath(projectDir: string): ClasspathResult {
    // implementation
}
```

Multiple IDs are comma-separated:

```typescript
/** @Requirements CORE_0001, CORE_0002 */
function discoverAndFilterRecipes(projectDir: string): Recipe[] {
    // implementation
}
```

### `@SVCs` — JSDoc tag on the test function/block

```typescript
/** @SVCs SVC_CORE_0001 */
test("discoverRecipes returns available recipes", () => {
    // GIVEN a project with recipes on the classpath
    // WHEN discoverRecipes is called
    // THEN available recipes are returned
});

/** @SVCs SVC_CORE_0005 */
test("resolveClasspath handles Maven project", () => {
    // GIVEN a Maven project directory
    // WHEN resolveClasspath is called
    // THEN the classpath is resolved successfully
});
```

## References

- [reqstool-java-annotations](https://github.com/reqstool/reqstool-java-annotations)
- [reqstool-python-decorators](https://github.com/reqstool/reqstool-python-decorators)
- [reqstool-typescript-tags](https://github.com/reqstool/reqstool-typescript-tags)
