# Property-Based Testing (PBT)

## いつ使うか (適用条件)

roundtrip 対 (encode/decode, serialize/deserialize)、正規化や冪等な変換、数学的性質を持つ純関数、参照実装の再実装など、入力全域で成り立つ**性質 (property)** を言える関数。例示ベース (同値分割・境界値分析) は期待値を1件ずつ列挙できるときに強く、PBT は「どの入力を与えても性質 P が成り立つ」と言える場合に強い。

## 導出手順

**導出・実装は trailofbits-property-based-testing スキルに委譲する。** 性質カタログ・ジェネレータ・ライブラリ選定・shrinking 処理はそちらが専門。stdd では「いつ選ぶか」の判断のみを担当。

## 実装パターン

同上 — 実装詳細は trailofbits-property-based-testing スキルを参照。

## 科学的根拠

- Claessen, K. & Hughes, J. (2000), "QuickCheck: A Lightweight Tool for Random Testing of Haskell Programs", Proceedings of the 5th ACM SIGPLAN International Conference on Functional Programming (ICFP '00) — property-based testing の原点的フレームワークを確立した論文。性質に基づくテスト生成のパラダイムを初めて定式化した。

## 限界と誤用

- 性質の定義が「実装そのもの」の写しになるとテストにならない (検証対象がない)
- 期待値が料金表など仕様表で明示的に与えられる領域は example-based (同値分割・境界値分析) の領分
- 初期値の選定を誤ると、性質は成り立つが実装の盲点を検出できない場合がある
