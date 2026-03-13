# OpenSpec + reqstool Spec Conventions

## Principle: reqstool is SSOT

reqstool owns all requirements and verification scenarios (GIVEN/WHEN/THEN).
OpenSpec spec.md files reference reqstool IDs — they NEVER duplicate requirement
descriptions or scenario steps.

## How to look up requirements and SVCs

Requirements and SVCs are defined in the system-level reqstool files. Subprojects
import them via filters — the actual content lives in the parent.

**To get requirement and SVC details, use the reqstool CLI.**

Read `.reqstool-ai.yaml` to find the system and module paths, then run:

```bash
# For a specific module's requirements/SVCs
reqstool generate-json local -p <module.path>

# For system-level (all requirements/SVCs)
reqstool generate-json local -p <system.path>
```

The JSON output contains:
- `requirements` — keyed by `urn:ID` (e.g., `myproject:CORE_0001`), includes title, description, significance
- `svcs` — keyed by `urn:SVC_ID` (e.g., `myproject:SVC_CORE_0001`), includes title, description (GIVEN/WHEN/THEN), requirement_ids
- `svcs_from_req` — maps requirement IDs to their SVC IDs

**Do NOT read YAML files directly** — use the CLI, as not all information might be available locally but in a repository for Maven, PyPi etc.

## spec.md Format

Reference requirement and SVC IDs only. The word SHALL is required by OpenSpec strict validation.

```markdown
## ADDED Requirements

### Requirement: <REQUIREMENT_ID>
The system SHALL implement <REQUIREMENT_ID>.

#### Scenario: <SVC_ID>
The system SHALL pass <SVC_ID>.
```

### Multiple scenarios under one requirement

```markdown
### Requirement: CORE_0002
The system SHALL implement CORE_0002.

#### Scenario: SVC_CORE_0002.1
The system SHALL pass SVC_CORE_0002.1.

#### Scenario: SVC_CORE_0002.2
The system SHALL pass SVC_CORE_0002.2.
```

### Parent requirement with children

When a requirement has been decomposed (see `reqstool-decomposition-conventions.md`),
list the parent and its children together:

```markdown
### Requirement: CLI_0004
The system SHALL implement CLI_0004.

#### Scenario: SVC_CLI_0004
The system SHALL pass SVC_CLI_0004.

### Requirement: CLI_0004.1
The system SHALL implement CLI_0004.1.

#### Scenario: SVC_CLI_0004.1
The system SHALL pass SVC_CLI_0004.1.

### Requirement: CLI_0004.2
The system SHALL implement CLI_0004.2.

#### Scenario: SVC_CLI_0004.2
The system SHALL pass SVC_CLI_0004.2.
```

### Multiple requirements

```markdown
## ADDED Requirements

### Requirement: CORE_0001
The system SHALL implement CORE_0001.

#### Scenario: SVC_CORE_0001
The system SHALL pass SVC_CORE_0001.

### Requirement: CORE_0002
The system SHALL implement CORE_0002.

#### Scenario: SVC_CORE_0002
The system SHALL pass SVC_CORE_0002.
```

## Task Generation: Annotation Tasks

When generating implementation tasks (e.g., `tasks.md`) from a `spec.md` that references
reqstool IDs, the task list **MUST** include tasks for adding code annotations. The spec.md
establishes traceability at the specification level; annotations close the loop at the code level.

### Rule

For every requirement ID and SVC ID referenced in `spec.md`:

- Include a task to add `@Requirements` (or language equivalent) on the implementing method
- Include a task to add `@SVCs` (or language equivalent) on the test method

Place these tasks in the **same section as the implementation or test task they belong to** —
not in a separate "annotations" section. Annotations are part of the implementation, not an
afterthought.

### Example

Given this spec.md:

```markdown
### Requirement: EVENT_0001
The system SHALL implement EVENT_0001.

#### Scenario: SVC_EVENT_0001
The system SHALL pass SVC_EVENT_0001.
```

The generated tasks should include:

```markdown
## 4. BillService — Core Logic

- [ ] 4.1 Create `BillService` with `handleInstallmentDue(InstallmentDueEvent)` method
- [ ] 4.2 Add `@Requirements({"EVENT_0001"})` to `handleInstallmentDue`
- [ ] ...

## 7. Unit Tests

- [ ] 7.1 `BillServiceTest`: test new bill creation
- [ ] 7.2 Add `@SVCs({"SVC_EVENT_0001"})` to the test method from 7.1
- [ ] ...
```

### Why

Without explicit annotation tasks, the spec.md references reqstool IDs but the generated code
may not include the corresponding `@Requirements` / `@SVCs` annotations. This breaks the
traceability chain: reqstool can only verify coverage when annotations are present in the code.

See `reqstool-annotation-conventions.md` for annotation placement rules.

## Rules

1. **DRY**: Never duplicate requirement descriptions or GIVEN/WHEN/THEN from reqstool
2. **SHALL**: Every requirement and scenario MUST contain the word SHALL (required by `openspec validate --strict`)
3. **IDs only**: Reference requirement IDs and SVC IDs — do not include file paths or descriptions
4. **One requirement per `### Requirement:` header**: Use the reqstool ID as the header name
5. **One scenario per `#### Scenario:` header**: Use the reqstool SVC ID as the header name
6. **Use reqstool CLI**: To look up details, run `reqstool generate-json local -p <path>`
7. **Validate**: Always run `openspec validate --all --strict` after creating or modifying specs
8. **Annotations in tasks**: When generating tasks from a spec.md that references reqstool IDs, include explicit tasks for adding `@Requirements` and `@SVCs` annotations (see "Task Generation: Annotation Tasks" above)

## Validation

```bash
# Validate a specific change
openspec validate <change-name> --type change --strict --json

# Validate everything
openspec validate --all --strict --json
```
