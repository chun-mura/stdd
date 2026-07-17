---
description: 対象コードとテスト観点から適用手法を選択し、具体テストケース一覧を導出して docs/test-design/ に保存する
argument-hint: [対象ファイル/機能。省略時は git diff と docs/test-perspectives/ の最新ファイル]
---

**入力解決**: $ARGUMENTS があれば対象とする。未指定なら `git diff` + `git diff --staged` の変更内容から対象を確定。docs/test-perspectives/ に最新ファイルがあれば観点リストとして読み込み、must 観点を最優先 (なければ観点なしで単体動作)。

**手法選択**: stdd の test-design-methods skill の選択フロー (skills/test-design-methods/SKILL.md 参照) に従って対象コードに適した手法を割り当てる。該当手法がない場合は SKILL.md を読み追記。

**導出**: 選んだ手法の references にある導出手順に従って成果物 (同値クラス表 / 境界一覧表 / デシジョンテーブル) を作成。省略・直感列挙は禁止。

**既存テスト控除**: 既にテスト済みのケースは「カバー済み」と記載して新規ケースから除外。

**出力ドキュメント生成**: `docs/test-design/YYYY-MM-DD-<slug>.md` に保存 (日付は `date +%F` で取得、slug は対象の英語ケバブケース要約)。ディレクトリが無ければ作成。構成:
- 対象 (ファイル/機能、test-perspectives 参照があればそのパス)
- 適用手法と選択理由 (選ばなかった主要手法の理由も1行)
- 導出成果物 (表をそのまま掲載)
- テストケース一覧: ID / 入力 / 期待結果 / 優先度 (must/should/could) / 導出元 (手法+成果物の行)

**テストコード は書かない**: must ケースから順に1件ずつ superpowers:test-driven-development の RED に入力する旨を末尾に記載。
