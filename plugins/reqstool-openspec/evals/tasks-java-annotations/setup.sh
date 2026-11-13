#!/usr/bin/env bash
# Seed a change whose spec delta references CORE_0002 and two SVCs.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes/." .
mkdir -p openspec/changes/add-gradle-support/specs/classpath
cat > openspec/changes/add-gradle-support/specs/classpath/spec.md <<'EOF'
## ADDED Requirements

### Requirement: CORE_0002
The system SHALL implement CORE_0002.

#### Scenario: SVC_CORE_0002.1
- **WHEN** SVC_CORE_0002.1 is run
- **THEN** it passes

#### Scenario: SVC_CORE_0002.2
- **WHEN** SVC_CORE_0002.2 is run
- **THEN** it passes
EOF
