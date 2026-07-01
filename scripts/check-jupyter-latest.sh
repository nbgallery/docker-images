#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="jupyter"
REPO="base-notebook"
API="https://quay.io/api/v1/repository/${NAMESPACE}/${REPO}/tag/"

page=1
all_tags="[]"
while :; do
  resp=$(curl -fsSL "${API}?onlyActiveTags=true&limit=100&page=${page}")
  chunk=$(echo "$resp" | jq -c '.tags')
  all_tags=$(jq -c -s '.[0] + .[1]' <(echo "$all_tags") <(echo "$chunk"))
  has_more=$(echo "$resp" | jq -r '.has_additional')
  [[ "$has_more" == "true" ]] || break
  page=$((page + 1))
done

latest_digest=$(echo "$all_tags" | jq -r '.[] | select(.name=="latest") | .manifest_digest')

if [[ -z "$latest_digest" || "$latest_digest" == "null" ]]; then
  echo "Couldn't resolve digest for :latest" >&2
  exit 1
fi

# Every tag sharing latest's digest belongs to this release
mirror_tags=$(echo "$all_tags" | jq -r --arg d "$latest_digest" \
  '[.[] | select(.manifest_digest == $d) | .name] | join(",")')

echo "latest_digest=${latest_digest}"
echo "mirror_tags=${mirror_tags}"