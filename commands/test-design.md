---
description: 対象コードとテスト観点から適用手法を選択し、具体テストケース一覧を導出して docs/test-design/ に保存する
argument-hint: [対象ファイル/機能。省略時は git diff と docs/test-perspectives/ の最新ファイル]
---

**対象**: `$ARGUMENTS`、なければ `git diff` と staged diff。最新の `docs/test-perspectives/` は must 観点だけを抽出する。

**導出**: `test-design-methods` の選択フローで手法を決め、必要な reference だけを読む。導出表を正本にし、直感列挙しない。既存テストで満たす行には `covered` を付ける。

**保存**: `docs/test-design/YYYY-MM-DD-<slug>.md`。構成は対象、手法（不採用主要手法は各1行）、導出表、ケース表のみ。導出表の行に `D-…` を付け、ケース表は `ID / 導出行 ID / 優先度 / 状態` とする。作成時の状態は `未実装`、同期後は `実装済み / 乖離 / 未実装` を使う。入力・期待結果をケース表に重複させない。must から TDD の RED に渡す。
