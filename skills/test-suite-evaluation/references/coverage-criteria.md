# カバレッジ基準

## 判断

`statement ⊂ branch ⊂ MC-DC`。condition coverage はこの鎖の外で、branch を包含しない。通常は branch、認可・課金・安全機構などの複合条件には MC-DC を使う。

## 導出

1. 未実行分岐を特定する。
2. クリティカルな複合条件では、各条件が独立に判定を変える n+1 程度の対を作る。
3. 未実行分岐を `test-design-methods` の選択フローへ渡す。

数値目標だけで十分性を判断しない。根拠は `docs/evidence.md`（Coverage）。
