# Property-Based Testing

## 適用

roundtrip、正規化、冪等変換、数学的性質を表明できる純関数に使う。仕様表で期待値を列挙できる領域は example-based を優先する。

性質、ジェネレータ、shrinking、ライブラリ選定は `trailofbits-property-based-testing` に委譲する。導出表は `D-ID / 性質 / ジェネレータ制約 / 失敗時の回帰化` とする。根拠は `docs/evidence.md`（PBT）。
