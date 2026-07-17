# 同値分割 (Equivalence Partitioning)

## いつ使うか (適用条件)

入力に範囲・カテゴリ・列挙値があり、同じクラスに属する値は同じ挙動 (同じコードパスを通る) と期待できるとき。全入力値を個別にテストする代わりに、代表値で1クラスを代表させて網羅性を保ちつつケース数を絞る。

## 導出手順

1. 対象パラメータごとに、仕様上の条件 (範囲・カテゴリ・フォーマット等) を列挙する
2. 各条件を**有効クラス (valid partition)** と**無効クラス (invalid partition)** に分ける。無効クラスを見落とさない — エラー処理・バリデーションの欠陥はここに出る
3. 各クラスから代表値を1つ選ぶ (境界値は境界値分析側で別途扱う)
4. クラス表を作る: `入力 × クラス × 代表値 × 期待結果`
5. **1テストケースで複数の無効クラスを同時に踏まない**: 複数の無効クラスを1回の呼び出しで同時に成立させると、どの無効クラスが実際に検出されたか特定できず、テストが何を保証しているか監査できなくなる。無効クラスは1クラスにつき最低1ケースを独立に用意する

### クラス表の書式例

| 入力 | クラス | 代表値 | 期待結果 |
|---|---|---|---|
| age | 有効: 0〜150 | 30 | 受理 |
| age | 無効: 負数 | -1 | エラー "age must be >= 0" |
| age | 無効: 150超 | 200 | エラー "age must be <= 150" |
| age | 無効: 非数値 | "abc" | エラー "age must be a number" |

## 実装パターン

言語非依存の原則: 導出したクラス表をテストコードと1対1対応させ、表自体をコメントとして残す。表の行が増減したらテストケースも同数増減するようにし、乖離を防ぐ。

```python
# equivalence classes: see docs/test-design/*.md
@pytest.mark.parametrize("age,expected", [
    (30, "accepted"),       # valid: 0-150
    (-1, "age must be >= 0"),   # invalid: negative
    (200, "age must be <= 150"),  # invalid: over 150
])
def test_age_partition(age, expected):
    ...
```

JS/TS では `test.each` が同じ役割を果たす (クラス表の行をそのまま配列にする)。

## 科学的根拠

- ISTQB Foundation Level Syllabus v4.0 (2023), §4.2.1 "Equivalence Partitioning" — 同値分割の定義・有効/無効パーティションの区別・派生手順の標準的定式化を裏付ける
- Myers, Sandler, Badgett, "The Art of Software Testing", 3rd Edition (Wiley, 2011) — 同値分割の古典的定式化 (条件から有効/無効クラスを導く手順) を裏付ける
- ISO/IEC/IEEE 29119-4:2021 (2nd edition), "Software and systems engineering — Software testing — Part 4: Test techniques" — 同値分割をテスト技法として国際規格上に定義していることを裏付ける
- Reid, S. (1997), "An empirical analysis of equivalence partitioning, boundary value analysis and random testing", Proceedings of the 4th International Software Metrics Symposium (IEEE METRICS) — 実運用の航空機システム (Ada, 約2万行) を対象に EP/BVA/ランダムテストの欠陥検出力を比較した実証研究の存在を裏付ける (結論の方向性は境界値分析側を参照。具体的な検出率の数値は検索で一次情報を確認できなかったため本ファイルには記載しない)

## 限界と誤用

- 「同じクラス内の値は同じ挙動をする」という仮定が誤っている場合 (実装が仕様と異なる形で分岐している場合) は欠陥を見逃す
- クラス分割が粗すぎる (仕様の条件分岐を見落とす) と、無効クラスの一部が未検証のまま残る
- 数値範囲の端点付近の欠陥はこの技法単体では検出しにくい → 境界値分析 (`boundary-value-analysis.md`) と併用する
