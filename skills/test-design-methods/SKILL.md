---
name: test-design-methods
description: Use when writing or planning test cases and deciding which inputs, boundaries, or combinations to test — after test perspectives are listed but concrete cases are not yet derived, when tests are being written ad hoc from examples only, or when unsure how many cases are enough for an input range, a rule set, or a state machine.
---

# test-design-methods

対象コードの特性から適切なテスト設計手法を選び、テストケースを機械的に導出する。テストコードを書く前に発動する。superpowers:test-driven-development の RED で書く「次の1テスト」の中身をここで導出する。

## 鉄則

テストケースは**導出成果物** (同値クラス表 / 境界一覧 / デシジョンテーブル) から作る。成果物なしで直感的にケースを列挙すると、網羅性を第三者が監査できない。導出成果物なしの直感列挙は禁止。

## 手法選択フロー

| コード特性 | 手法 | 参照 |
|---|---|---|
| 入力に範囲・閾値・サイズ制限がある | 同値分割 → 各クラスの境界に境界値分析 | `references/equivalence-partitioning.md` → `references/boundary-value-analysis.md` |
| 複数条件の組合せで挙動が決まる (割引・権限・バリデーションルール) | デシジョンテーブル | `references/decision-table.md` |
| 状態・呼び出し順序に依存する | 状態遷移テスト | `references/state-transition.md` |
| 独立パラメータが多く全組合せが爆発する | ペアワイズ | `references/pairwise.md` |
| roundtrip・不変条件を持つ純関数 / シリアライザ / パーサ | property-based testing → **trailofbits-property-based-testing スキルに委譲** (性質カタログ・ジェネレータ・ライブラリ選定はそちらが担当。stdd では扱わない) | — |
| 信頼できない入力を読むパーサ / デシリアライザ | fuzz (Phase 3 で追加予定・未収録) | — |

複数の手法に該当する場合は併用する (同値分割 + 境界値分析が通常セット)。

## 適用手順

1. 対象の入力・条件を列挙する
2. 上記フローで手法を選ぶ (複数可)
3. 各 reference の「導出手順」に従って成果物 (表) を作る
4. 成果物の各行をテストケース化する。優先順位は must から (`docs/test-perspectives/` に最新ファイルがあれば、その must 観点を優先してケース化する)
5. 成果物をテストコードのコメント or docstring に残し、後から監査できるようにする

## 掲載ルール (references への手法追加の不変条件)

references/ への手法追加は「科学的根拠」セクションに検証済みの出典があるものに限る。出典が確認できない手法・数値は掲載禁止。
