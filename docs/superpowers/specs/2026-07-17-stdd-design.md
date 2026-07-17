# stdd — Scientific Test-Driven Development 設計

日付: 2026-07-17
ステータス: フェーズ1 実装予定 (v0.2.0 で初期資産)

## 目的

科学的根拠 (ISTQB シラバス・研究論文・実証研究) 付きのテスト設計手法カタログ + 手法選択ガイド + テストスイート品質評価を提供する Claude Code プラグイン。出典なしの手法は掲載しない。

## aidd / superpowers / uidd との棲み分け (三層 + ドメイン)

```
superpowers … how to proceed (process): TDD規律・デバッグ・計画
aidd         … what to test (汎用task): 観点洗い出し + 優先度付け (test-perspectives)
stdd         … how to derive (ドメイン): 手法選択 + ケース導出 + スイート品質評価
uidd         … UIドメイン特化 (同格の前例)
```

判断基準: 全プロジェクト・全フェーズで同じ振る舞いか → superpowers/aidd。テスト設計というドメイン知識に紐づくか → stdd。

## 境界線の明示的定義 (重複禁止の担保)

| 相手 | 相手の担当 | stdd の担当 | 連携ポイント |
|---|---|---|---|
| superpowers:test-driven-development | test-first の順序規律 | RED で書く「次の1テスト」の中身の導出 | stdd の導出ケース一覧を TDD サイクルの入力キューにする |
| aidd:test-perspectives | 6観点の列挙 + must/should/could | 観点→具体ケースへの手法適用 | `docs/test-perspectives/` の最新ファイルを `/stdd:test-design` の入力にする |
| aidd 側の軽量拡張 (別タスク予定) | 「この観点は BVA/ECP が要る」とフラグを立てる判断基準 (1行ヒューリスティクス) | フラグが立った後の手法の実行手順 (境界値の導出手順・同値クラスの分割手順・出典) | aidd 拡張は stdd への1行ポインタを含める (実装は別セッション) |
| trailofbits-property-based-testing | PBT の実行方法 (性質カタログ・ジェネレータ・言語別ライブラリ) | PBT を「いつ選ぶか」の判断 + 選択後のポインタ | stdd の手法選択フローで PBT が選ばれたら同スキルへ委譲。references/property-based.md は選択基準 + 科学的根拠 + ポインタのみで how-to を書かない |

## 非機能テストのスコープ判断

- **セキュリティ**: aidd:test-perspectives が信頼境界に触れる変更でのみ「セキュリティ (条件付き)」観点 (認可・入力検証・エラーレスポンスの情報量・ログの機微データマスク) を出力し、`/stdd:test-design` へ導出を委譲する。stdd 側に専用の手法ファイルは追加しない — これらの観点はドメインであって導出手法ではなく、既存手法で導出できるため (認可→デシジョンテーブル、入力検証→同値分割/境界値分析、信頼できない入力を読むパーサ→fuzz)。専用ファイルを作ると既存手法の再掲になり運用ルール4 (重複禁止) に反する
- **性能・負荷**: aidd:test-perspectives がコミット単位の観点に馴染まないとしてスコープ外を宣言している。stdd 側も対称にスコープ外とし、専用手法は追加しない
- 再検討条件: 上記のいずれかで「既存手法では導出できない」という具体的な失敗事例が実プロジェクトで発生したとき

## dependencies を宣言しない判断

stdd の skill/command は superpowers・aidd の資産をランタイム呼び出ししない。連携は「aidd の出力ファイル (`docs/test-perspectives/YYYY-MM-DD-*.md`) があれば入力として読む」だけで、無くても単体で動く。よって manifest 依存は不要 (uidd の前例と同判断)。README に併用推奨のみ記載。

## 資産構成 (計画)

```
commands/
└── test-design.md               # /stdd:test-design — 対象コード(+test-perspectives出力)から手法を選択し、具体ケース一覧を docs/test-design/YYYY-MM-DD-<slug>.md に生成
skills/
├── test-design-methods/         # テストを書く前に発動: 手法選択フロー + references (1手法1ファイル)
│   └── references/              # BVA / ECP / decision-table / state-transition / pairwise / property-based(ポインタ) / fuzz
└── test-suite-evaluation/       # テストが揃った後に発動: mutation testing / カバレッジ基準 (branch, MC-DC)
    └── references/              # mutation-testing / coverage-criteria
```

skill を2つに分ける理由: 発動タイミングが異なる (設計時 vs 評価時)。1つに束ねるとトリガ記述が濁る。agents / hooks は作らない (2回ルールで必要になってから昇格)。

## references/ 共通テンプレートと掲載ルール

```markdown
# <手法名>

## いつ使うか (適用条件)      ← コード特性ベースの判断基準。冒頭に置く
## 導出手順                   ← 番号付きステップ。入力→テストケース一覧が機械的に出る粒度
## 実装パターン               ← 言語非依存の原則 + 主要エコシステム1-2例
## 科学的根拠 (必須)          ← 出典なしの手法は掲載禁止
## 限界と誤用                 ← 手法が効かないケース
```

掲載ルール (不変条件): 科学的根拠セクションが空の手法ファイルは追加禁止。出典は実装時に実在と主張内容を検証してから記載する。

## フェーズ計画

- Phase 1 (v0.2.0): test-design-methods skill + BVA / ECP / decision-table + サブエージェント検証 (superpowers:writing-skills の RED→GREEN 方式)
- Phase 2 (v0.3.0): /stdd:test-design command + state-transition / pairwise
- Phase 3 (v0.4.0): property-based(ポインタ) / fuzz + test-suite-evaluation skill
- Phase 4: aidd 側の1行ポインタ追加 (別セッション・別リポジトリ)

## 検証方針

1. CI: `claude plugin validate --strict` + version bump 強制
2. skill 実効性: superpowers:writing-skills の subagent テスト (スキルなし baseline の失敗を確認してから、スキルありの改善を確認)
3. エンドツーエンド: test-perspectives 出力 → /stdd:test-design → ケース表に手法名と出典が付くこと
