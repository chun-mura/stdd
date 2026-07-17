---
description: mutation testing を実行し、生存 mutant を docs/test-design/ のケース一覧と突き合わせて不足テストケースを提案する
argument-hint: [対象モジュール/ファイル。省略時は git diff の変更対象]
---

**入力解決**: $ARGUMENTS があれば対象モジュールとする。未指定なら `git diff` + `git diff --staged` の変更ファイルから対象を確定。全体には掛けない — 重要ロジック優先・差分限定の運用原則 (skills/test-suite-evaluation/references/mutation-testing.md) に従う。

**ツール選択と実行**: 対象言語から mutation ツールを選ぶ (Python: mutmut / JavaScript・TypeScript: Stryker / JVM: PIT — 詳細は references/mutation-testing.md)。ツール未導入ならインストールコマンドを提示し、確認を取ってから導入する。実行は対象ファイルに限定する (mutmut は paths_to_mutate、Stryker は mutate オプション、PIT は --targetClasses)。

**生存 mutant の分類**: references/mutation-testing.md の分類に従い、生き残った mutant を (a) テスト不足 / (b) 等価 mutant / (c) 到達不能コード に振り分ける。(b) は記録して除外、(c) は削除候補として報告し、(a) のみ次工程へ渡す。

**ケース一覧との突き合わせ**: `docs/test-design/` から対象に対応する設計書を探して読み、(a) の各 mutant (ファイル・行・変異内容) をケース一覧と照合して判定する:
- 対応するケースが一覧にある → 「実装漏れ」(ケースはあるがテストが未実装、またはアサーションが変異を検出できない)
- 対応するケースが一覧にない → 「設計漏れ」— test-design-methods の選択フロー (skills/test-design-methods/SKILL.md) で手法を選び、references の導出手順に従って不足ケースを具体的に導出する。直感列挙は禁止
- 対象の設計書自体が存在しない → 全 mutant を設計漏れとして扱い、先に `/stdd:test-design` の実行を促して終了する

**出力**: 対象の設計書のケース一覧に導出した不足ケースを追記する (導出元列に `mutation: <変異内容の要約>` を記載)。追記後、レポートを提示する: 生存 mutant の分類結果 / 実装漏れ・設計漏れの対応表 / mutation score (同一モジュールの時系列比較用。絶対値目標にしない — Goodhart の法則)。must ケースから順に superpowers:test-driven-development の RED に入力する旨を末尾に記載する。
