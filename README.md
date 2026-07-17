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

(準備中 — Phase 1 で追加予定)

| ファイル | 入力 → 出力 | 説明 |
|---------|-----------|------|

### Skills (自動トリガする知見)

(準備中 — Phase 1 で追加予定)

| ファイル | 発火条件 |
|---------|------|

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
