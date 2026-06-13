#!/usr/bin/env bash
set -euo pipefail

errors=0
adoc="docs/modules/ROOT/pages/skills.adoc"
readme="README.md"

# Forward check: every references/*.md on disk must be listed in
# SKILL.md, skills.adoc, and README.md
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
# reference tables must exist on disk under some references/ directory
while IFS= read -r filename; do
  [ -n "$filename" ] || continue
  if ! find plugins -path "*/references/$filename" -type f | grep -q .; then
    echo "::error::$filename listed in $adoc but not found under any references/ dir"
    errors=1
  fi
done < <(grep -oE '`[A-Za-z0-9._-]+\.md`' "$adoc" | tr -d '`' | sort -u)

while IFS= read -r filename; do
  [ -n "$filename" ] || continue
  if ! find plugins -path "*/references/$filename" -type f | grep -q .; then
    echo "::error::$filename listed in $readme but not found under any references/ dir"
    errors=1
  fi
done < <(grep -oE '\*\*[A-Za-z0-9._-]+\.md\*\*' "$readme" | tr -d '*' | sort -u)

if [ "$errors" -ne 0 ]; then
  exit 1
fi

echo "All skill reference docs are consistently listed."
