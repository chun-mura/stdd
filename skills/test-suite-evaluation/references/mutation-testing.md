# ミューテーション・テスティング (Mutation Testing)

## いつ使うか (適用条件)

テストの「検出力」を測りたいとき。カバレッジが高いのに品質が不安なスイート、リファクタ前の安全網評価、テストがアサーションを持っているかの機械的確認が必要なときに使う。単体テスト・統合テストの両方で適用可能だが、実行コストが大きいため、全体に掛けず重要ロジック優先で運用する。

## 導出手順

1. 対象モジュールを選定する (全体に掛けない — 重要ロジック優先。参考: 暗号・認可・課金・状態管理)
2. ツールで mutant (ソースコードの小さな変更) を生成・実行する
3. 生き残り mutant (テストで検出されなかった mutant) を分類する:
   - (a) テスト不足 → テストケース追加検討 (test-design-methods の手法選択フローへ入力)
   - (b) 等価 mutant (プログラムの挙動が実質同じ変更) → 記録して除外
   - (c) 到達不能コード → 削除検討
4. mutation score は「同一モジュールの時系列比較」に使い、絶対値目標 (「X% を達成」) にしない (Goodhart の法則)

## 実装パターン

言語別に1つずつ推奨 (3つまで):

- **Python**: `mutmut` (pip install mutmut)。CI では差分対象のみに掛ける運用 (git diff --name-only でフィルタ)
- **JavaScript/TypeScript**: `Stryker` (npm install @stryker-mutator/core)。設定: mutate オプションで対象ファイル指定
- **JVM (Java/Kotlin)**: `PIT` (gradle/maven プラグイン)。CI 統合時は --targetClasses で重要パッケージ指定

CI では全テストではなく差分対象のみに掛ける (実行時間削減)。

## 科学的根拠

- Jia, Y. and Harman, M. (2011). "An Analysis and Survey of the Development of Mutation Testing." IEEE Transactions on Software Engineering, Vol. 37, No. 5, pp. 649–678 — mutation testing の発展史と基礎理論を包括的に調査。mutation operators の定式化と効果の実証
- Just, R., Jalali, D., Inozemtseva, L., Ernst, M. D., Holmes, R., and Fraser, G. (2014). "Are Mutants a Valid Substitute for Real Faults in Software Testing?" Proceedings of the 22nd ACM SIGSOFT International Symposium on Foundations of Software Engineering (FSE), pp. 654–665 — 357 個の実欠陥と mutant 検出の相関を実証。「mutant を検出できるテストは実欠陥も検出しやすい」という信頼性を確立
- Papadakis, M., Kintis, J., Zhang, J., Jia, Y., Le Traon, Y., and Harman, M. (2019). "Mutation Testing Advances: An Analysis and Survey." Advances in Computers, Vol. 112, pp. 275–378 — 最新の mutation testing 技術、ツール、応用事例をサーベイ。高コスト問題への対策 (equivalent mutant 検出、並列化) を解説

## 限界と誤用

- **実行コストが高い**: 全対象をカバーすると時間がかかる。重要ロジックに限定し、CI では差分対象のみに適用
- **等価 mutant の判定が困難**: 「この mutant は実質等価か」を自動判定することは決定不可能問題。手作業または静的解析で判定が必要
- **score の絶対値化**: 「mutation score 85% を達成」といった目標は Goodhart の法則に陥る。代わりに「前月から改善したか」という時系列トレンドを見る
