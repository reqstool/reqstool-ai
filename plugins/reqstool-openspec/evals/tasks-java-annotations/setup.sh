#!/usr/bin/env bash
# Seed a change whose spec delta references CORE_0002 and two SVCs.
cp -a "$(dirname "$0")/../_fixtures/acme-recipes/." .
mkdir -p openspec/changes/add-gradle-support/specs/classpath
cat > openspec/changes/add-gradle-support/specs/classpath/spec.md <<'EOF'
## ADDED Requirements

### Requirement: CORE_0002
The system SHALL implement CORE_0002.

#### Scenario: SVC_CORE_0002.1
The system SHALL pass SVC_CORE_0002.1.

#### Scenario: SVC_CORE_0002.2
The system SHALL pass SVC_CORE_0002.2.
EOF
