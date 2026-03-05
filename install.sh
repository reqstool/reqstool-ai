#!/usr/bin/env bash
set -euo pipefail

# reqstool-ai installer
# Copies reqstool AI-assisted skills and commands into a target project.
# Currently supports Claude Code. Other integrations may be added in the future.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOL="claude"
WITH_OPENSPEC=false

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] <target-project-dir>

Install reqstool-ai skills and commands into a project.

Options:
  --tool <name>     AI tool integration to install (default: claude)
                    Available: claude
  --with-openspec   Also install OpenSpec integration (conventions + config rules)
  -h, --help        Show this help message

Examples:
  $(basename "$0") /path/to/my-project
  $(basename "$0") --with-openspec /path/to/my-project
  $(basename "$0") --tool claude --with-openspec /path/to/my-project
EOF
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --tool)
      TOOL="$2"
      shift 2
      ;;
    --with-openspec)
      WITH_OPENSPEC=true
      shift
      ;;
    -h|--help)
      usage
      ;;
    -*)
      echo "Error: Unknown option: $1" >&2
      exit 1
      ;;
    *)
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

if [[ -z "${TARGET_DIR:-}" ]]; then
  echo "Error: Target project directory is required." >&2
  echo "Run '$(basename "$0") --help' for usage." >&2
  exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: Directory does not exist: $TARGET_DIR" >&2
  exit 1
fi

# Validate tool
TOOL_DIR="$SCRIPT_DIR/$TOOL"
if [[ ! -d "$TOOL_DIR" ]]; then
  echo "Error: Unknown tool '$TOOL'. Available: claude" >&2
  exit 1
fi

echo "Installing reqstool-ai ($TOOL) into: $TARGET_DIR"
echo ""

# --- Tool-specific installation ---

if [[ "$TOOL" == "claude" ]]; then
  CLAUDE_DIR="$TARGET_DIR/.claude"
  mkdir -p "$CLAUDE_DIR"

  # Skills and commands share names — derive command name from skill name
  SKILLS=(reqstool-status reqstool-add-req reqstool-add-svc reqstool-sync-filters)

  # Copy skills
  for skill in "${SKILLS[@]}"; do
    dest="$CLAUDE_DIR/skills/$skill"
    action="Installed"
    [[ -f "$dest/SKILL.md" ]] && action="Updated"
    mkdir -p "$dest"
    cp "$TOOL_DIR/skills/$skill/SKILL.md" "$dest/SKILL.md"
    echo "  $action skill: $skill"
  done

  # Copy commands
  dest="$CLAUDE_DIR/commands/reqstool"
  mkdir -p "$dest"
  for skill in "${SKILLS[@]}"; do
    cmd="${skill#reqstool-}"
    action="Installed"
    [[ -f "$dest/$cmd.md" ]] && action="Updated"
    cp "$TOOL_DIR/commands/reqstool/$cmd.md" "$dest/$cmd.md"
    echo "  $action command: reqstool/$cmd"
  done

  # Copy core conventions (always — not gated by --with-openspec)
  for conv in reqstool-conventions.md reqstool-annotation-conventions.md reqstool-decomposition-conventions.md; do
    action="Installed"
    [[ -f "$CLAUDE_DIR/$conv" ]] && action="Updated"
    cp "$SCRIPT_DIR/$conv" "$CLAUDE_DIR/$conv"
    echo "  $action: .claude/$conv"
  done

  # Append reqstool section to CLAUDE.md if not already present
  CLAUDE_MD="$TARGET_DIR/CLAUDE.md"
  MARKER="always read \`.claude/reqstool-conventions.md\` first"
  if [[ -f "$CLAUDE_MD" ]] && grep -qF "$MARKER" "$CLAUDE_MD"; then
    echo "  CLAUDE.md already contains reqstool section (skipped)"
  else
    action="Created"
    [[ -f "$CLAUDE_MD" ]] && action="Updated"
    # Extract the actual snippet content (everything after the --- separator)
    {
      echo ""
      sed -n '/^---$/,$ { /^---$/d; p; }' "$TOOL_DIR/CLAUDE-snippet.md"
    } >> "$CLAUDE_MD"
    echo "  $action: CLAUDE.md (appended reqstool section)"
  fi
fi

# --- Shared config (tool-neutral) ---

CONFIG_FILE="$TARGET_DIR/.reqstool-ai.yaml"
if [[ -f "$CONFIG_FILE" ]]; then
  echo ""
  echo "  Config already exists: .reqstool-ai.yaml (skipped)"
else
  cp "$SCRIPT_DIR/config/reqstool-ai.yaml.template" "$CONFIG_FILE"
  echo ""
  echo "  Created config: .reqstool-ai.yaml"
fi

# --- OpenSpec integration (optional) ---

if [[ "$WITH_OPENSPEC" == true ]]; then
  echo ""
  echo "Installing OpenSpec integration..."

  if [[ "$TOOL" == "claude" ]]; then
    # Copy conventions file to .claude/ (Claude reads from there)
    action="Installed"
    [[ -f "$TARGET_DIR/.claude/reqstool-openspec-conventions.md" ]] && action="Updated"
    cp "$SCRIPT_DIR/openspec/reqstool-openspec-conventions.md" "$TARGET_DIR/.claude/reqstool-openspec-conventions.md"
    echo "  $action: .claude/reqstool-openspec-conventions.md"
  fi

  # Merge reqstool rules into openspec/config.yaml
  OPENSPEC_CONFIG="$TARGET_DIR/openspec/config.yaml"
  RULES_MARKER="reqstool is SSOT"
  if [[ -f "$OPENSPEC_CONFIG" ]]; then
    if grep -qF "$RULES_MARKER" "$OPENSPEC_CONFIG"; then
      echo "  openspec/config.yaml already contains reqstool rules (skipped)"
    else
      # Read the specs rules from config-rules.yaml and indent them under the existing rules: key
      # The rules file has a `specs:` key with items — we append each item under the existing specs: key
      echo "" >> "$OPENSPEC_CONFIG"
      echo "    # reqstool rules (added by reqstool-ai installer)" >> "$OPENSPEC_CONFIG"
      # Extract just the rule lines (the - "..." entries) and indent them for the rules.specs context
      sed -n 's/^  - /    - /p' "$SCRIPT_DIR/openspec/config-rules.yaml" >> "$OPENSPEC_CONFIG"
      echo "  Updated: openspec/config.yaml (appended reqstool specs rules)"
      echo ""
      echo "  NOTE: The reqstool rules were appended to openspec/config.yaml."
      echo "        Please verify they are correctly placed under 'rules: specs:' in your config."
    fi
  else
    echo "  openspec/config.yaml not found — skipping rules merge"
    echo "  When you create openspec/config.yaml, add the rules from openspec/config-rules.yaml"
  fi
fi

# --- Done ---

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .reqstool-ai.yaml with your project's URN, paths, and module prefixes"
