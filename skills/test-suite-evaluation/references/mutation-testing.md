# ミューテーション・テスティング

## 適用

高カバレッジでも検出力が不明なスイート、リファクタ前の重要ロジックに限定して使う。

## 導出

1. 重要モジュールだけを対象に mutant を生成・実行する。
2. survivor をテスト不足、等価 mutant、到達不能コードに分類する。
3. テスト不足だけを `test-design-methods` へ渡す。
4. score は同一モジュールの時系列比較に使い、絶対目標にしない。

Python は mutmut、JS/TS は Stryker、JVM は PIT を候補にし、CI は差分対象に限定する。根拠は `docs/evidence.md`（Mutation）。
