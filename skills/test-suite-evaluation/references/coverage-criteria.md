# カバレッジ基準 (Coverage Criteria)

## いつ使うか (適用条件)

カバレッジ数値の解釈・目標設定の議論・クリティカルな条件ロジック (認可・課金・安全機構) の検証水準決定に使う。「カバレッジ 80% で十分か」という問いに答えるには、まず「何の 80%」かを確認する必要がある。基準の種類 (statement vs. branch vs. MC-DC) によって意味が大きく変わる。

## 導出手順

1. カバレッジ基準の包含関係 (subsumption) を理解する: **statement ⊂ branch ⊂ MC-DC**。condition はこの鎖の外にある
   - **Statement coverage** (最弱): 全ステートメントが実行されたか。制御フロー分岐は見ない
   - **Branch (decision) coverage**: 全分岐 (if-else, case) の true/false 両側が実行されたか。statement を包含する。通常のコードの基準線
   - **Condition coverage**: 複合条件内の各条件単独が true/false 両側実行されたか。**branch を包含しない**点に注意 — 例: `if (A || B)` は {A=T,B=F} と {A=F,B=T} の2ケースで condition 100% だが、decision は常に true で false 側の分岐が未実行
   - **MC-DC (Modified Condition/Decision Coverage)** (最強): 各条件が独立に結果を変えることを示すテスト対 (最小 n+1 ケース) を導出する。branch と condition の両方を包含する。クリティカルロジック専用
2. 対象コードの性質から基準を選ぶ:
   - 通常: branch coverage を基準線に (リファクタ前の安全網評価なら branch を確認)
   - クリティカル (認可・課金・安全機構): MC-DC を導出する
3. MC-DC 導出の小例:
   ```
   アクセス許可 = (ユーザー権限 == "admin") AND (アカウント有効 == true)
   必要テスト対数: 2 + 1 = 3 ケース
   テスト1: admin, 有効 → 許可 (baseline)
   テスト2: admin, 無効 → 拒否 (第2条件の影響を示す)
   テスト3: 非admin, 有効 → 拒否 (第1条件の影響を示す)
   各条件が独立に結果を変えることが示される
   ```

## 実装パターン

branch カバレッジの計測フラグ例 (2つまで):

- **Python**: `pytest-cov --cov-branch` で branch coverage 集計。未実行分岐レポートを HTML で確認
- **Go**: `go test -cover -coverprofile=coverage.out` で statement coverage 集計。標準ツールチェーンは branch coverage 非対応 (並行テストでのカウンタ競合防止には `-covermode=atomic` を使うが、これは branch とは無関係)

計測ツールの出力から未実行分岐を特定 → test-design-methods の選択フローに入力して、対応する設計手法 (同値分割・境界値分析・デシジョンテーブル等) を選ぶ。

## 科学的根拠

Chilenski & Miller 1994 (MC-DC 原典) / DO-178B/C / Inozemtseva & Holmes 2014 (ICSE — coverage と effectiveness の相関は低い) / Hutchins et al. 1994 (ICSE) — 全文は `sources.md` 参照

## 限界と誤用

- **数値目標の一律強制**: 「全コードで branch 100%」という目標は測定ゲーム (アサーション無しのテストで数値だけ上がる) につながる。代わりに、クリティカルモジュールに MC-DC、通常コードに branch を段階的に適用
- **MC-DC のコスト**: 複合条件が複数ある場合、n+1 ケースの導出と実装に工数がかかる。クリティカル箇所に限定して適用する
- **静的カバレッジツールの偽陽性**: 到達不能コード / 条件式の構文的畳み込み (例: `if (true && condition)`) により、カバレッジ数値が実態と異なることがある。計測結果は手で監査が必要
