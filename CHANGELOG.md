# Changelog

## 0.5.0 - 2026-07-17

外部レビュー指摘を受けたフィードバックループ command を2つ追加。2回ルール (実運用2回で昇格) の明示的な例外として導入した。

- `commands/mutation-check.md`: `/stdd:mutation-check` — mutation ツール (mutmut/Stryker/PIT) を差分限定で実行し、生存 mutant を分類 (テスト不足/等価/到達不能) した上で `docs/test-design/` のケース一覧と突き合わせ、「実装漏れ」「設計漏れ」を判定。設計漏れは test-design-methods の選択フローで不足ケースを導出してケース一覧に追記する
- `commands/test-design-sync.md`: `/stdd:test-design-sync` — テスト設計書のケース一覧と実テストコードを read-only サブエージェントで並列照合し、実装済み/乖離/未実装/設計外テストを判定。承認後にケース一覧へ「状態」列を反映する (aidd:design-sync と同型の設計)
- `docs/superpowers/specs/2026-07-17-stdd-design.md`: 非機能テストのスコープ判断を追記 (セキュリティ観点は既存手法で導出、性能・負荷はスコープ外)
- `README.md`: Commands インデックスに2 command を追加

## 0.4.0 - 2026-07-17

Phase 3 資産を追加。手法カタログの完成と、スイート十分性評価の第2 skill を導入した。

- `skills/test-design-methods/references/property-based.md`: property-based testing の選択基準・科学的根拠・trailofbits-property-based-testing スキルへの委譲ポインタ (運用ルール4: how-to は書かない)
- `skills/test-design-methods/references/fuzz.md`: fuzz testing (attack surface 特定 → ハーネス → カバレッジガイド付き実行 → クラッシュ入力の回帰昇格)。検証済み出典付き
- `skills/test-suite-evaluation/`: 第2の自動発動 skill — カバレッジ数値を無批判に受け入れず、mutation testing とカバレッジ基準の強度階層でスイートの信頼性を判断する。references 2ファイル (mutation-testing / coverage-criteria)。生き残り mutant・未実行分岐を test-design-methods の選択フローに入力する連携点を明記
- `README.md`: Skills インデックスに test-suite-evaluation を追加

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
