#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

test -f docs/evidence.md
! test -e docs/superpowers
! test -e docs/test-implementation-conventions.md
! test -e skills/test-design-methods/references/sources.md
! test -e skills/test-suite-evaluation/references/sources.md

while IFS= read -r reference; do
  rg -q 'docs/evidence.md' "$reference"
done < <(find skills -path '*/references/*.md' -type f | sort)

rg -q '導出表の1行を.*テストケース' skills/test-design-methods/SKILL.md
! rg -q 'docs/test-implementation-conventions.md' skills commands README.md
rg -q '必要な reference だけを読む' commands/test-design.md
rg -q '導出行 ID' commands/test-design.md
rg -q '候補テストだけを読む' commands/test-design-sync.md
rg -q '導出表から入力・期待結果を1行に投影' commands/test-design-sync.md
rg -q '正規化' commands/mutation-check.md
rg -q '導出表へ.*mutation' commands/mutation-check.md
rg -q 'experimental' commands/test-design-sync.md
rg -q 'experimental' README.md
rg -Fq 'Reid, S. (1997)' docs/evidence.md
rg -Fq 'Jia, Y. and Harman, M. (2011)' docs/evidence.md

jq -e '.version == "0.6.2"' .claude-plugin/plugin.json >/dev/null
echo 'plugin asset checks passed'
