---
name: test-design-methods
description: Use when writing or planning test cases and deciding which inputs, boundaries, or combinations to test — after test perspectives are listed but concrete cases are not yet derived, when tests are being written ad hoc from examples only, or when unsure how many cases are enough for an input range, a rule set, or a state machine.
---

# test-design-methods

テストコードの前に、対象の性質から手法を選び、導出表の行をケース化する。直感だけで列挙しない。

## 手法選択フロー

| コード特性 | 手法 | 参照 |
|---|---|---|
| 入力に範囲・閾値・サイズ制限がある | 同値分割 + 境界値分析 | `references/equivalence-partitioning.md`, `references/boundary-value-analysis.md` |
| 複数条件の組合せで挙動が決まる (割引・権限・バリデーションルール) | デシジョンテーブル | `references/decision-table.md` |
| 状態・呼び出し順序に依存する | 状態遷移テスト | `references/state-transition.md` |
| 独立パラメータが多く全組合せが爆発する | ペアワイズ | `references/pairwise.md` |
| roundtrip・不変条件を持つ純関数 / シリアライザ / パーサ | PBT を trailofbits-property-based-testing に委譲 | `references/property-based.md` |
| 信頼できない入力を読むパーサ / デシリアライザ | fuzz | `references/fuzz.md` |

複数該当時は併用する。必要な reference だけを読み、入力・条件→導出表→ケースの順に進める。既存の `docs/test-perspectives/` があれば must を優先する。

## 実装規約

- 導出表の1行を、原則として1つのテストケースまたは parameterized test の1行に対応させ、D-ID をコメント等に残す。
- 無効クラス・否定側ルール・無効遷移は独立に検証する。
- 組合せの制約、境界の分解能と on/off 規約は設計書に残し、言語固有の記法は対象プロジェクトの既存規約を優先する。
