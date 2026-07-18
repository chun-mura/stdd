# 出典一覧 (Sources)

各手法の「科学的根拠」の全文をここに集約する。references の各ファイルには出典キーのみを記載する (トークン効率のため)。

**掲載ルール (不変条件)**: references/ への手法追加は、本ファイルに検証済みの出典を登録したものに限る。出典が確認できない手法・数値は掲載禁止 (test-design-methods と同一ルール)。

## ミューテーション・テスティング (mutation-testing.md)

- Jia, Y. and Harman, M. (2011). "An Analysis and Survey of the Development of Mutation Testing." IEEE Transactions on Software Engineering, Vol. 37, No. 5, pp. 649–678 — mutation testing の発展史と基礎理論を包括的に調査。mutation operators の定式化と効果の実証
- Just, R., Jalali, D., Inozemtseva, L., Ernst, M. D., Holmes, R., and Fraser, G. (2014). "Are Mutants a Valid Substitute for Real Faults in Software Testing?" Proceedings of the 22nd ACM SIGSOFT International Symposium on Foundations of Software Engineering (FSE), pp. 654–665 — 357 個の実欠陥と mutant 検出の相関を実証。「mutant を検出できるテストは実欠陥も検出しやすい」という信頼性を確立
- Papadakis, M., Kintis, M., Zhang, J., Jia, Y., Le Traon, Y., and Harman, M. (2019). "Mutation Testing Advances: An Analysis and Survey." Advances in Computers, Vol. 112, pp. 275–378 — 最新の mutation testing 技術、ツール、応用事例をサーベイ。高コスト問題への対策 (equivalent mutant 検出、並列化) を解説

## カバレッジ基準 (coverage-criteria.md)

- Chilenski, J. and Miller, S. (1994). "Applicability of Modified Condition/Decision Coverage to Software Testing." Software Engineering Journal, Vol. 9, No. 5, pp. 193–200 — MC-DC の原典。複合条件を含むクリティカルロジックの検証水準を定義した基盤論文。各条件が独立に結果を変えることの検証必要性を立証
- DO-178B/C (EUROCAE ED-12B/C) — 航空機認証の国際規格。DAL A (最高安全度レベル) ソフトウェアに 100% MC-DC カバレッジを要求。業界標準での採用が MC-DC の実用性を証明
- Inozemtseva, L. and Holmes, R. (2014). "Coverage Is Not Strongly Correlated with Test Suite Effectiveness." Proceedings of the 36th International Conference on Software Engineering (ICSE), pp. 435–445 — 5 個の大規模 Java プロジェクト (100K+ LOC 各) で mutation testing を適用。「coverage と effectiveness の相関は低い」ことを実証。カバレッジが高いだけでは品質保証にならないことを定量的に示す
- Hutchins, M., Foster, H., Goradia, T., and Ostrand, T. (1994). "Experiments on the Effectiveness of Dataflow- and Control-Flow-Based Test Adequacy Criteria." Proceedings of the 16th International Conference on Software Engineering (ICSE) — 7 プログラム・130 個の欠陥バージョンで all-edges/all-DUs カバレッジを検証。カバレッジ 90% 以上で欠陥検出率が有意に向上する一方、100% 近くでも検出保証にはならないことを実証
