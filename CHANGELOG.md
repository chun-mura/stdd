# Changelog

## 0.3.0 - 2026-07-17

Phase 2 資産を追加。ユーザ起動 command と手法カタログの拡充。

- `commands/test-design.md`: `/stdd:test-design` — 対象コード (+ aidd test-perspectives の観点出力があればそれ) から手法を選択し、導出成果物と具体テストケース一覧を `docs/test-design/YYYY-MM-DD-<slug>.md` に生成する。aidd 非依存で単体動作する
- `skills/test-design-methods/references/state-transition.md`: 状態遷移テスト (状態遷移表・無効遷移・カバレッジ水準 0-switch/1-switch)。検証済み出典付き
- `skills/test-design-methods/references/pairwise.md`: ペアワイズテスト (PICT によるツール生成・デシジョンテーブルとの選び分け)。検証済み出典付き
- `README.md`: Commands インデックスに /stdd:test-design を追加

## 0.2.0 - 2026-07-17

Phase 1 資産を追加。テスト設計手法の中核 skill を導入した。

- `skills/test-design-methods/`: 手法選択フロー (SKILL.md) + 手法カタログ references 3ファイル (同値分割 / 境界値分析 / デシジョンテーブル)。全手法に検証済み出典付き (ISTQB Foundation v4.0 / Myers / ISO/IEC/IEEE 29119-4 / Reid 1997)。property-based testing は trailofbits-property-based-testing スキルへ委譲 (運用ルール4)
- superpowers:writing-skills 方式のサブエージェント検証 (RED→GREEN) を実施: スキルなしで観測した4つの失敗モード (導出成果物なし / ルール否定側の欠落 / 組合せ選定のアドホック性 / off-point の非系統性) がスキルありで全て解消することを確認
- `README.md`: Skills インデックスに test-design-methods を追加

## 0.1.0 - 2026-07-17

初期スキャフォールド。プラグイン骨格 (plugin.json / marketplace.json / README / CI) のみで資産は未収録。

- `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`: プラグイン定義 (dependencies なしのスタンドアロン構成、運用ルール4に基づき superpowers/aidd へはポインタ参照のみ)
- `README.md`: 棲み分け定義・運用ルール5原則・併用推奨を記載
- `.github/workflows/validate.yml`: uidd と同じ検証 CI を導入
