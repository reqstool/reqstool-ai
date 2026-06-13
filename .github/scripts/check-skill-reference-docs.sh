#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

errors=0
adoc="docs/modules/ROOT/pages/skills.adoc"
readme="README.md"

# Forward check: every references/*.md on disk must be listed in:
#   - the skill's SKILL.md, as `references/<filename>`
#   - skills.adoc, as a backtick-wrapped `<filename>` (table cell)
#   - README.md, as a bold **<filename>** (list item)
#
# NOTE: these patterns encode the *current* formatting conventions used in
# skills.adoc / README.md / SKILL.md. If those docs are reformatted (e.g. a
# different markup style for the reference tables/lists), this script must
# be updated in lockstep, or every entry will start failing.
#
# Scope: only these three listings are checked. Per-skill "entry point"
# docs (e.g. reqstool-conventions.md, which links to the other convention
# docs) are intentionally not cross-checked, since not every skill has one
# and its link format isn't standardized across skills.
while IFS= read -r -d '' file; do
  filename=$(basename "$file")
  skill_dir=$(dirname "$(dirname "$file")")
  skill_md="$skill_dir/SKILL.md"

  if ! grep -qF "references/$filename" "$skill_md"; then
    echo "::error::$filename not referenced in $skill_md"
    errors=1
  fi
  if ! grep -qF "\`$filename\`" "$adoc"; then
    echo "::error::$filename not referenced in $adoc"
    errors=1
  fi
  if ! grep -qF "**$filename**" "$readme"; then
    echo "::error::$filename not referenced in $readme"
    errors=1
  fi
done < <(find plugins -path '*/references/*.md' -print0)

# Reverse check: every *.md filename listed in skills.adoc / README.md
# reference tables must exist on disk under some references/ directory.
check_reverse() {
  local file="$1" pattern="$2" strip_chars="$3"
  local filename
  while IFS= read -r filename; do
    [ -n "$filename" ] || continue
    if ! find plugins -path "*/references/$filename" -type f | grep -q .; then
      echo "::error::$filename listed in $file but not found under any references/ dir"
      errors=1
    fi
  done < <(grep -oE "$pattern" "$file" | tr -d "$strip_chars" | sort -u)
}

# skills.adoc lists filenames as `reqstool-overview.md` (backtick-wrapped)
check_reverse "$adoc" '`[A-Za-z0-9._-]+\.md`' '`'
# README.md lists filenames as **reqstool-overview.md** (bold)
check_reverse "$readme" '\*\*[A-Za-z0-9._-]+\.md\*\*' '*'

if [ "$errors" -ne 0 ]; then
  exit 1
fi

echo "All skill reference docs are consistently listed."
