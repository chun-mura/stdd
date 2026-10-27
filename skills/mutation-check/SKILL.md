---
name: mutation-check
description: mutation testing を実行し、生存 mutant を docs/test-design/ のケース一覧と突き合わせて不足テストケースを提案する
argument-hint: [対象モジュール/ファイル。省略時は git diff の変更対象]
disable-model-invocation: true
---

**パスと引数の解決**: この文書の相対パスは、この SKILL.md があるディレクトリを起点にする。`$ARGUMENTS` が文字のまま残っている場合（Codex・Cursor など）は、この skill を呼び出したメッセージのうち skill 名以外の部分を `$ARGUMENTS` とみなす。

**入力解決**: $ARGUMENTS があれば対象モジュールとする。未指定なら `git diff` + `git diff --staged` の変更ファイルから対象を確定。全体には掛けない — 重要ロジック優先・差分限定の運用原則 (`../test-suite-evaluation/references/mutation-testing.md`) に従う。

**ツール選択と実行**: 対象言語から mutation ツールを選ぶ (Python: mutmut / JavaScript・TypeScript: Stryker / JVM: PIT — 詳細は `../test-suite-evaluation/references/mutation-testing.md`)。ツール未導入ならインストールコマンドを提示し、確認を取ってから導入する。実行は対象ファイルに限定する (mutmut は paths_to_mutate、Stryker は mutate オプション、PIT は --targetClasses)。

**生存 mutant の分類**: 先に survivor を `ファイル:行 / 演算子 / 元→変異 / 件数` に正規化し、同一項目を重複排除する。原文ログは分類不能な項目だけ開く。`../test-suite-evaluation/references/mutation-testing.md` に従い、(a) テスト不足 / (b) 等価 mutant / (c) 到達不能コードに分ける。(b) は記録、(c) は削除候補、(a) だけ次工程へ渡す。

**ケース一覧との突き合わせ**: `docs/test-design/` から対象に対応する設計書を探して読み、(a) の各 mutant (ファイル・行・変異内容) をケース一覧と照合して判定する:
- 対応するケースが一覧にある → 「実装漏れ」(ケースはあるがテストが未実装、またはアサーションが変異を検出できない)
- 対応するケースが一覧にない → 「設計漏れ」— test-design-methods の選択フロー (`../test-design-methods/SKILL.md`) で手法を選び、references の導出手順に従って不足ケースを具体的に導出する。直感列挙は禁止
- 対象の設計書自体が存在しない → 全 mutant を設計漏れとして扱い、先に `/stdd:test-design` の実行を促して終了する

**出力**: 設計漏れごとに、まず導出表へ `D-ID / 入力・条件 / 期待結果 / mutation: <要約>` を追加し、その D-ID を参照するケース表行を追加する。レポートは分類件数、実装漏れ・設計漏れの ID 対応、score のみとし、詳細は必要時に原文ログを参照する。must から TDD の RED に渡す。
