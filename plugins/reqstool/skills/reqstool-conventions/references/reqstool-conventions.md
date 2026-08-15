# reqstool Conventions

For an overview of reqstool concepts (architecture, imports, filters, implementations), see `reqstool-overview.md`.

## Tooling Division of Labor

Three interfaces exist; use each for what it is good at:

- **Look up** requirements, SVCs, and per-requirement status through the
  reqstool MCP tools (`get_requirement`, `list_svcs`, `get_requirements_status`,
  …) rather than reading whole YAML files — cheaper and more precise as the
  requirement set grows.
- **Edit** the reqstool YAML files directly (they are the SSOT).
- **Verify** only with the CLI gate (`reqstool status local -p <path>`), run
  against a fresh full build. The CLI joins the YAML model with generated
  annotation files and test results; a clean build matters because incremental
  compilation can truncate generated annotation files.

Never cite MCP status output as a gate verdict: the MCP server loads
everything — the YAML model *and* the generated annotation/test-result
artifacts — once at startup, with no reload and no staleness detection. A
long-lived server silently serves whatever snapshot existed when it spawned
(including zeros, if artifacts were absent at that moment). A freshly spawned
server against a fresh full build does match the CLI, but nothing tells you
whether either condition holds, so treat its status tools as browsing aids
until the server gains reload and staleness detection.

## Source Code Annotations

When writing or modifying code with reqstool annotations (`@Requirements`, `@SVCs`),
follow the conventions in `reqstool-annotation-conventions.md`.

## Requirement Decomposition

When decomposing requirements into parent-child hierarchies, using lifecycle states,
or working with dot-notation IDs, follow the conventions in
`reqstool-decomposition-conventions.md`.

## Build & Test Runner Configuration

When configuring build tools or test runners so reqstool can correctly map test
results to `@SVCs` annotations (e.g. parameterized test display names), follow
`reqstool-build-config-conventions.md`.

## Configuration (`.reqstool-ai.yaml`)

All skills read `.reqstool-ai.yaml` from the project root. It defines:

| Field | Description |
|-------|-------------|
| `urn` | Project URN used in reqstool YAML files and filter keys |
| `revision` | Version string for new requirements and SVCs |
| `system.path` | Path to the system-level reqstool directory (SSOT) |
| `modules.<name>.path` | Path to a subproject's reqstool directory (contains filter files) |
| `modules.<name>.req_prefix` | Requirement ID prefix for this module (e.g., `CORE_`). Set to `""` for domain-specific prefix projects where IDs are managed manually |
| `modules.<name>.svc_prefix` | SVC ID prefix for this module (e.g., `SVC_CORE_`) |

## OpenSpec Integration

For OpenSpec integration, install the `reqstool-openspec` plugin from this marketplace:
`/plugin install reqstool-openspec@reqstool-ai --scope project`

It provides conventions for referencing reqstool IDs in OpenSpec spec.md files.
