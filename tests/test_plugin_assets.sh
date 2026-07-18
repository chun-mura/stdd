#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

test -f docs/evidence.md
test -f docs/test-implementation-conventions.md
! test -e skills/test-design-methods/references/sources.md
! test -e skills/test-suite-evaluation/references/sources.md

while IFS= read -r reference; do
  rg -q 'docs/evidence.md' "$reference"
done < <(find skills -path '*/references/*.md' -type f | sort)

while IFS= read -r reference; do
  rg -q 'docs/test-implementation-conventions.md' "$reference"
done < <(find skills/test-design-methods/references -name '*.md' -type f | sort)
rg -q '必要な reference だけを読む' commands/test-design.md
rg -q '導出行 ID' commands/test-design.md
rg -q '候補テストだけを読む' commands/test-design-sync.md
rg -q '導出表から入力・期待結果を1行に投影' commands/test-design-sync.md
rg -q '正規化' commands/mutation-check.md
rg -q '導出表へ.*mutation' commands/mutation-check.md
rg -q 'Reid, S. (1997)' docs/evidence.md
rg -q 'Jia, Y. and Harman, M. (2011)' docs/evidence.md

jq -e '.version == "0.6.0"' .claude-plugin/plugin.json >/dev/null
echo 'plugin asset checks passed'
