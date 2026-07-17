---
name: test-suite-evaluation
description: Use when judging whether an existing test suite is trustworthy — before relying on green tests for a refactor, when coverage numbers are cited as evidence of quality, or when deciding whether more tests are needed and which kind.
---

# test-suite-evaluation

既存テストスイートの十分性を定量的に判断する。test-design-methods が「テストを書く前」の設計手法なのに対し、本スキルは「揃った後・green を信頼する前」に発動する。リファクタ前の安全網評価や「カバレッジ X% は十分か」という議論に使う。

## 鉄則

**カバレッジは「テストされていない箇所」を見つけるには使えるが、「テストが十分」の証明には使えない**。この非対称性を理解しないと、無批判にカバレッジ数値を品質の証拠として受け入れてしまう。カバレッジが高い = 品質が高い、という推論は成立しない。

## 判断フロー

| 問い | 対応アクション | 参照 |
|---|---|---|
| 「このスイートを信頼してリファクタしてよいか」 | 変更対象モジュールの branch カバレッジを確認 (未実行分岐を列挙) → 重要ロジックに mutation testing を適用 | `references/mutation-testing.md`, `references/coverage-criteria.md` |
| 「カバレッジ X% は十分か」 | 基準の種類を確認 (statement ⊂ branch ⊂ condition ⊂ MC-DC の強度階層) → 数値目標の一律適用はアンチパターン | `references/coverage-criteria.md` |
| 「テストを増やすべきか・どの種類か」 | 生き残った mutant と未実行分岐を列挙 → test-design-methods の選択フローに入力して手法を選ぶ | `references/mutation-testing.md` + test-design-methods 連携 |

## 掲載ルール

references/ への追加は「科学的根拠」セクションに検証済み出典があるものに限る。出典が確認できない手法・数値は掲載禁止 (test-design-methods と同一ルール)。
