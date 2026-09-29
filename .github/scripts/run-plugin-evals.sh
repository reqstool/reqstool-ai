#!/usr/bin/env bash
# Run the Plugin Evals workflow with an Anthropic API key that exists in GitHub
# only for this run: it is set as a plugin-evals environment secret and deleted
# when this script exits, however it exits.
#
# Usage: .github/scripts/run-plugin-evals.sh [-f runs=1 -f max_cost_usd=5 ...]
# The key is read from $ANTHROPIC_API_KEY_FILE if set, otherwise prompted for.
set -euo pipefail

repo=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
env_name=plugin-evals
secret=ANTHROPIC_API_KEY

if [[ -n "${ANTHROPIC_API_KEY_FILE:-}" ]]; then
  key=$(<"$ANTHROPIC_API_KEY_FILE")
else
  read -rsp "Anthropic API key: " key
  echo
fi
[[ -n "$key" ]] || { echo "No key given" >&2; exit 1; }

cleanup() {
  gh secret delete "$secret" --env "$env_name" --repo "$repo" \
    || echo "WARNING: could not delete $secret from the $env_name environment; remove it by hand" >&2
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# stdin, not --body, so the key never appears in argv
printf '%s' "$key" | gh secret set "$secret" --env "$env_name" --repo "$repo"
unset key

out=$(gh workflow run plugin-evals.yml --repo "$repo" --ref main "$@")
echo "$out"
run_id=$(grep -oE '/actions/runs/[0-9]+' <<<"$out" | grep -oE '[0-9]+$') \
  || { echo "Could not find the run id in the gh output" >&2; exit 1; }

gh run watch "$run_id" --repo "$repo" --exit-status
