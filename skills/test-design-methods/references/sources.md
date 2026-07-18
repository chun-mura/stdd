# 出典一覧 (Sources)

各手法の「科学的根拠」の全文をここに集約する。references の各ファイルには出典キーのみを記載する (トークン効率のため)。

**掲載ルール (不変条件)**: references/ への手法追加は、本ファイルに検証済みの出典を登録したものに限る。出典が確認できない手法・数値は掲載禁止。

## 同値分割 (equivalence-partitioning.md)

- ISTQB Foundation Level Syllabus v4.0 (2023), §4.2.1 "Equivalence Partitioning" — 同値分割の定義・有効/無効パーティションの区別・派生手順の標準的定式化を裏付ける
- Myers, Sandler, Badgett, "The Art of Software Testing", 3rd Edition (Wiley, 2011) — 同値分割の古典的定式化 (条件から有効/無効クラスを導く手順) を裏付ける
- ISO/IEC/IEEE 29119-4:2021 (2nd edition), "Software and systems engineering — Software testing — Part 4: Test techniques" — 同値分割をテスト技法として国際規格上に定義していることを裏付ける
- Reid, S. (1997), "An empirical analysis of equivalence partitioning, boundary value analysis and random testing", Proceedings of the 4th International Software Metrics Symposium (IEEE METRICS) — 実運用の航空機システム (Ada, 約2万行) を対象に EP/BVA/ランダムテストの欠陥検出力を比較した実証研究の存在を裏付ける (結論の方向性は境界値分析側を参照。具体的な検出率の数値は検索で一次情報を確認できなかったため記載しない)

## 境界値分析 (boundary-value-analysis.md)

- ISTQB Foundation Level Syllabus v4.0 (2023), §4.2.2 "Boundary Value Analysis" — 境界値分析の定義、2値法/3値法の区別、境界値が欠陥の集中する箇所であるという根拠づけを裏付ける
- Myers, Sandler, Badgett, "The Art of Software Testing", 3rd Edition (Wiley, 2011) — 境界値分析の古典的定式化 (同値分割の境界に着目する手順) を裏付ける
- ISO/IEC/IEEE 29119-4:2021 (2nd edition), "Software and systems engineering — Software testing — Part 4: Test techniques" — 境界値分析をテスト技法として国際規格上に定義していることを裏付ける
- Reid, S. (1997), "An empirical analysis of equivalence partitioning, boundary value analysis and random testing", Proceedings of the 4th International Software Metrics Symposium (IEEE METRICS) — 実運用の航空機システム (Ada, 約2万行) を対象にした実証研究で、境界値分析が同値分割・ランダムテストより欠陥検出力が高かったと報告されていることを複数の独立した検索結果で確認した (具体的な検出率の数値は一次情報 [IEEE Xplore doc 637166] の本文を取得できず確認できなかったため記載しない)

## デシジョンテーブル (decision-table.md)

- ISTQB Foundation Level Syllabus v4.0 (2023), §4.2.3 "Decision Table Testing" — デシジョンテーブルの定義、条件の組合せからテストケースを導出する標準手順を裏付ける
- ISO/IEC/IEEE 29119-4:2021 (2nd edition), "Software and systems engineering — Software testing — Part 4: Test techniques" — デシジョンテーブルテストをテスト技法として国際規格上に定義していることを裏付ける

## 状態遷移テスト (state-transition.md)

- ISTQB Certified Tester Foundation Level Syllabus v4.0 (2023), §4.2.4 "State Transition Testing" — 状態遷移テストの定義、テスト手法としての標準的手順、状態・イベント・遷移の概念を裏付ける
- Chow, T.S. (1978) "Testing Software Design Modeled by Finite-State Machines", IEEE Transactions on Software Engineering, vol. 4, no. 3, pp. 178-187 — 有限状態機械による設計テストの原典的論文。N-switch カバレッジなど遷移ペア以上の多段階カバレッジ戦略の理論的基礎を裏付ける

## ペアワイズテスト (pairwise.md)

- Kuhn, D.R., Wallace, D.R., Gallo, A.M. (2004) "Software Fault Interactions and Implications for Software Testing", IEEE Transactions on Software Engineering, vol. 30, no. 6, pp. 418-421 — 実証研究。NASA および NIST の複数のソフトウェアシステムを対象に、欠陥を引き起こす変数間相互作用の実例を分析。結果: **大多数の欠陥は2個以下のパラメータの相互作用で引き起こされる** (相互作用が3つ以上の変数に及ぶ欠陥は数%以下)。ペアワイズ (2-way) 網羅で体系的に多くの欠陥が検出できる理論的根拠を与える
- NIST Automated Combinatorial Testing for Software (ACTS) — NIST が公開している実装資料・ツール・論文。「ペアワイズ網羅で実運用ソフトウェアの約60〜95%の欠陥が検出可能」という実績ベースの知見を提供。t-way (t=3,4,...) テストへの拡張ガイドも含む

## Property-Based Testing (property-based.md)

- Claessen, K. & Hughes, J. (2000), "QuickCheck: A Lightweight Tool for Random Testing of Haskell Programs", Proceedings of the 5th ACM SIGPLAN International Conference on Functional Programming (ICFP '00) — property-based testing の原点的フレームワークを確立した論文。性質に基づくテスト生成のパラダイムを初めて定式化した

## ファジング (fuzz.md)

- Miller, B. P., Fredriksen, L., & So, B. (1990), "An Empirical Study of the Reliability of UNIX Utilities", Communications of the ACM 33(12) — fuzzing の起源。約90個の UNIX ユーティリティを検査し、約25% がランダム入力で**クラッシュ**した。基本的なメモリ安全性・入力検証の欠陥が広く存在することを実証
- Seacord, R. C. (2013), "Secure Coding in C and C++", 2nd Edition (Addison-Wesley) — メモリ安全性違反の分類と、ファジングの検出効果
- Google OSS-Fuzz (2016–) — 継続的ファジング基盤。Google の公表 (2023年2月時点) で、1,000 以上のオープンソースプロジェクトから累積 8,900 以上の脆弱性・28,000 以上のバグを検出。実運用での効果を実証
