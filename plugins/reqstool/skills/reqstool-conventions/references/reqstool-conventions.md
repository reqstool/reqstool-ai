# reqstool Conventions

For an overview of reqstool concepts (architecture, imports, filters, implementations), see `reqstool-overview.md`.

## Tooling Division of Labor

Besides the YAML files themselves, reqstool has three interfaces — MCP, the LSP
server and the CLI; use each for what it is good at:

- **Query** through the reqstool MCP tools (`get_requirement`, `list_svcs`,
  `get_requirements_status`, `get_status`, …) rather than reading whole YAML
  files — cheaper and more precise as the requirement set grows.
- **Edit** the reqstool YAML files directly (they are the SSOT).
- **Validate** references as you edit with the reqstool LSP server
  (`reqstool lsp`), where your editor or harness runs it. It reports unknown
  requirement or SVC IDs in `@Requirements`/`@SVCs` annotations as errors,
  deprecated or obsolete ones as warnings, and YAML parse and schema errors; it
  also completes IDs and resolves definitions and references between
  annotations and YAML. It checks that references are valid, not that
  requirements are met, so it does not replace the status check.
- **Check** completeness with the MCP status tools while you work. They are a
  real check, not a browsing aid: `get_status`, `get_requirement_status`, and
  `get_requirements_status` all delegate to the same per-requirement verdict
  computation the CLI uses, so on the same inputs they return the same answer.
  Use `get_requirements_status` to find what is still unimplemented or untested
  instead of shelling out repeatedly.
- **Gate** with the CLI (`reqstool status --check-all-reqs-met local -p <path>`),
  run against a fresh full build. Same verdict, but it exits non-zero (200) when
  any requirement is unmet — so it is the form that belongs in CI and the one to
  cite. Without `--check-all-reqs-met` it always exits 0.

Checking and gating are separated for reasons of provenance, not of
correctness — MCP status is not the weaker number. A gate has to run where there
is no agent and no MCP client, has to leave an artifact someone else can
reproduce, and re-parses from a cold start rather than confirming the world-view
your session has been operating under all along.

In short: the LSP answers "is this reference valid?" while you type, MCP answers
"what is still unmet?" between edits, and the CLI answers "is it done?" once,
from a cold start, where no agent runs.

Freshness is not the same as a build. Since reqstool 0.12.1 the MCP server
re-checks the files it parsed before answering and reloads when they change, so
a server left running for days no longer serves its spawn-time snapshot — but
it re-reads artifacts, it does not produce them. Generated annotation files and
JUnit XML on disk are only as current as the last build, and incremental
compilation can truncate generated annotation files. Nothing in the freshness
check sequences your build, either: an MCP status call made before the build
finishes returns a fresh, well-formed, wrong answer. So run a clean full build
first and treat any completeness number as scoped to that build, whichever
interface you read it from.

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
