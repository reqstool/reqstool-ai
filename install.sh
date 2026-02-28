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
  --with-openspec   Also install OpenSpec integration (conventions file + setup instructions)
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

  # Copy skills
  for skill in reqstool-status reqstool-add-req reqstool-add-svc reqstool-sync-filters; do
    dest="$CLAUDE_DIR/skills/$skill"
    mkdir -p "$dest"
    cp "$TOOL_DIR/skills/$skill/SKILL.md" "$dest/SKILL.md"
    echo "  Installed skill: $skill"
  done

  # Copy commands
  dest="$CLAUDE_DIR/commands/reqstool"
  mkdir -p "$dest"
  for cmd in status add-req add-svc sync-filters; do
    cp "$TOOL_DIR/commands/reqstool/$cmd.md" "$dest/$cmd.md"
    echo "  Installed command: reqstool/$cmd"
  done

  # Copy core conventions (always — not gated by --with-openspec)
  cp "$SCRIPT_DIR/reqstool-conventions.md" "$CLAUDE_DIR/reqstool-conventions.md"
  echo "  Installed: .claude/reqstool-conventions.md"
  cp "$SCRIPT_DIR/reqstool-annotation-conventions.md" "$CLAUDE_DIR/reqstool-annotation-conventions.md"
  echo "  Installed: .claude/reqstool-annotation-conventions.md"
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
    cp "$SCRIPT_DIR/openspec/reqstool-openspec-conventions.md" "$TARGET_DIR/.claude/reqstool-openspec-conventions.md"
    echo "  Installed: .claude/reqstool-openspec-conventions.md"
  fi
fi

# --- Done ---

echo ""
echo "Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Edit .reqstool-ai.yaml with your project's URN, paths, and module prefixes"

if [[ "$TOOL" == "claude" ]]; then
  echo "  2. Add the following to your project's CLAUDE.md:"
  echo ""
  echo "     ## reqstool"
  echo ""
  echo "     When working with reqstool, **always read \`.claude/reqstool-conventions.md\` first**."
fi

if [[ "$WITH_OPENSPEC" == true ]]; then
  if [[ "$TOOL" == "claude" ]]; then
    echo ""
    echo "  3. Add the reqstool rules to your openspec/config.yaml (see openspec/config-rules.yaml)"
  fi
fi
