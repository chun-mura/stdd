---
name: test-suite-evaluation
description: Use when judging whether an existing test suite is trustworthy — before relying on green tests for a refactor, when coverage numbers are cited as evidence of quality, or when deciding whether more tests are needed and which kind.
---

# test-suite-evaluation

既存スイートを、green を信頼する前に評価する。カバレッジは未検証箇所の発見に使い、十分性の証明には使わない。

## 判断フロー

| 問い | 対応アクション | 参照 |
|---|---|---|
| 「このスイートを信頼してリファクタしてよいか」 | 変更対象モジュールの branch カバレッジを確認 (未実行分岐を列挙) → 重要ロジックに mutation testing を適用 | `references/mutation-testing.md`, `references/coverage-criteria.md` |
| 「カバレッジ X% は十分か」 | 基準の種類を確認 (statement ⊂ branch ⊂ condition ⊂ MC-DC の強度階層) → 数値目標の一律適用はアンチパターン | `references/coverage-criteria.md` |
| 「テストを増やすべきか・どの種類か」 | 生き残った mutant と未実行分岐を列挙 → test-design-methods の選択フローに入力して手法を選ぶ | `references/mutation-testing.md` + test-design-methods 連携 |
