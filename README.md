# stdd

科学的根拠に基づいたテスト設計手法カタログ・手法選択ガイド・テストスイート品質評価を提供する Claude Code プラグイン。

**棲み分け**: process は superpowers、汎用 task (test-perspectives 等) は aidd、テスト設計手法 (ケース導出・スイート品質評価) が stdd。UI ドメイン特化は uidd。

## 導入

```bash
/plugin marketplace add chun-mura/stdd
/plugin install stdd@stdd

# 併用推奨: superpowers (TDD プロセス規律) + aidd (test-perspectives の観点出力)
```

## インデックス

### Commands (タスク特化プロンプト)

| Command | 用途 |
|---|---|
| `/stdd:test-design` | 対象コードとテスト観点から適用手法を選択し、具体テストケース一覧を導出して `docs/test-design/` に保存する |
| `/stdd:mutation-check` | mutation testing を実行し、生存 mutant を `docs/test-design/` のケース一覧と突き合わせて不足ケースを提案する |
| `/stdd:test-design-sync` | テスト設計書と実テストコードの乖離を検知し、ケースの実装状態を最新化する |

### Skills (自動トリガする知見)

| Skill | いつ発動するか |
|---|---|
| `test-design-methods` | テストケースを書く前。入力の範囲・閾値・条件組合せから、同値分割・境界値分析・デシジョンテーブルで具体ケースを導出する |
| `test-suite-evaluation` | 既存テストスイートの十分性を判断するとき。green を信頼してリファクタする前、カバレッジ数値が品質の根拠として持ち出されたとき |

**2 skill の連携**: `test-design-methods` は「書く前」、`test-suite-evaluation` は「揃った後」に発動する。`test-suite-evaluation` が見つけた生き残り mutant・未実行分岐は、`test-design-methods` の手法選択フローへの入力として使う (ケース追加の起点)。

## 併用推奨

- **superpowers**: TDD プロセス規律 (Red-Green-Refactor サイクルの実行) は superpowers に委譲する
- **aidd**: test-perspectives の観点出力を stdd の各手法への入力として使う
- **trailofbits-property-based-testing**: PBT (property-based testing) の実行方法は同スキルに委譲する

## 運用ルール

1. 1ファイル1関心事 (冒頭に「いつ使うか」を書く)
2. 2回ルール (2回以上使ったプロンプトのみ資産に昇格)
3. 資産変更時は README インデックス + CHANGELOG + plugin.json version を同時更新
4. 重複禁止 (superpowers/aidd/trailofbits と重複する機能は作らずポインタのみ)
5. 受動ドキュメント禁止 (知見は skills=自動トリガ か hooks=強制 に置く)

> ⚠️ このプラグインは実プロジェクトでの検証が未実施である。
