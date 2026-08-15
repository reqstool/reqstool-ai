# reqstool Conventions

For an overview of reqstool concepts (architecture, imports, filters, implementations), see `reqstool-overview.md`.

## Tooling Division of Labor

Three interfaces exist; use each for what it is good at:

- **Query** through the reqstool MCP tools (`get_requirement`, `list_svcs`,
  `get_requirements_status`, `get_status`, …) rather than reading whole YAML
  files — cheaper and more precise as the requirement set grows. Status tools
  derive from the same verdict computation as the CLI, so they agree with it on
  the same inputs.
- **Edit** the reqstool YAML files directly (they are the SSOT).
- **Verify** with the CLI gate (`reqstool status local -p <path>`), run against
  a fresh full build. Its exit code is the number of unmet requirements, which
  is what makes it the thing to put in CI and to cite as a verdict.

Freshness is not the same as a build. Since reqstool 0.12.1 the MCP server
re-checks the files it parsed before answering and reloads when they change, so
a server left running for days no longer serves its spawn-time snapshot — but
it re-reads artifacts, it does not produce them. Generated annotation files and
JUnit XML on disk are only as current as the last build, and incremental
compilation can truncate generated annotation files. So run a clean full build
before treating any completeness number as real, whichever interface you read it
from.

When an MCP status answer looks wrong, check `snapshot` on `get_status`
(`built_at`, `tracked_files`, `warnings`) before assuming the data is stale — a
`test_results` pattern that matched no files is reported there rather than
counted as zero tests. `refresh` forces a reload; needing it usually means the
project is a remote source (git/maven/npm/pypi), which is version-pinned and
therefore never watched.

Older servers (reqstool < 0.12.1) do load everything once at startup with no
reload and no staleness detection: a long-lived one silently serves whatever
existed when it spawned, including zeros if the build had not run yet. Against
those, MCP status is a browsing aid only.

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
