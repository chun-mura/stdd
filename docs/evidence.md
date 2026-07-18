# 検証済み出典

通常のテスト設計では読まない証跡保管庫。reference の根拠キーをここで追跡する。

## EP / BVA

- ISTQB Foundation Level Syllabus v4.0 (2023), §§4.2.1–4.2.2 — 同値分割・境界値分析の標準定義と導出手順。
- Myers, Sandler, Badgett, *The Art of Software Testing*, 3rd ed. (Wiley, 2011) — EP/BVA の古典的定式化。
- ISO/IEC/IEEE 29119-4:2021, *Software testing — Part 4: Test techniques* — 国際規格上の定義。
- Reid, S. (1997), *An empirical analysis of equivalence partitioning, boundary value analysis and random testing*, IEEE METRICS — 航空機システムでの実証比較。

## Decision / state transition

- ISTQB Foundation Level Syllabus v4.0 (2023), §§4.2.3–4.2.4 — デシジョンテーブル・状態遷移の標準手順。
- ISO/IEC/IEEE 29119-4:2021 — デシジョンテーブルテストの国際規格上の定義。
- Chow, T.S. (1978), *Testing Software Design Modeled by Finite-State Machines*, IEEE TSE 4(3), 178–187 — N-switch の基礎。

## Pairwise / PBT / fuzz

- Kuhn, D.R., Wallace, D.R., Gallo, A.M. (2004), *Software Fault Interactions and Implications for Software Testing*, IEEE TSE 30(6), 418–421 — 相互作用次数の実証。
- NIST, *Automated Combinatorial Testing for Software (ACTS)* — 制約付き t-way 生成。
- Claessen, K. & Hughes, J. (2000), *QuickCheck: A Lightweight Tool for Random Testing of Haskell Programs*, ICFP '00 — PBT の基礎。
- Miller, B.P., Fredriksen, L., So, B. (1990), *An Empirical Study of the Reliability of UNIX Utilities*, CACM 33(12) — fuzzing の起源。
- Seacord, R.C. (2013), *Secure Coding in C and C++*, 2nd ed.; Google OSS-Fuzz public results — 安全性・継続的 fuzzing の根拠。

## Coverage / mutation

- Chilenski, J. & Miller, S. (1994), *Applicability of Modified Condition/Decision Coverage to Software Testing*, Software Engineering Journal 9(5), 193–200 — MC-DC。
- DO-178B/C (ED-12B/C) — 高安全度ソフトウェアの MC-DC 要求。
- Inozemtseva, L. & Holmes, R. (2014), *Coverage Is Not Strongly Correlated with Test Suite Effectiveness*, ICSE — coverage と有効性の相関。
- Hutchins, M. et al. (1994), *Experiments on the Effectiveness of Dataflow- and Control-Flow-Based Test Adequacy Criteria*, ICSE — adequacy 基準の実証。
- Jia, Y. and Harman, M. (2011), *An Analysis and Survey of the Development of Mutation Testing*, IEEE TSE 37(5), 649–678。
- Just, R. et al. (2014), *Are Mutants a Valid Substitute for Real Faults in Software Testing?*, FSE, 654–665。
- Papadakis, M. et al. (2019), *Mutation Testing Advances: An Analysis and Survey*, *Advances in Computers* 112, 275–378。

出典を追加する際は、手法・主張・一次または信頼できる二次出典の対応をこのファイルに記録する。
