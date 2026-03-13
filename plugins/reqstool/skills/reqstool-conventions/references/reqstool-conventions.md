# reqstool Conventions

For an overview of reqstool concepts (architecture, imports, filters, implementations), see `reqstool-overview.md`.

## Source Code Annotations

When writing or modifying code with reqstool annotations (`@Requirements`, `@SVCs`),
follow the conventions in `reqstool-annotation-conventions.md`.

## Requirement Decomposition

When decomposing requirements into parent-child hierarchies, using lifecycle states,
or working with dot-notation IDs, follow the conventions in
`reqstool-decomposition-conventions.md`.

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
