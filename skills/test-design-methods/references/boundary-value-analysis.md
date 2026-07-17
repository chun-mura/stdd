# 境界値分析 (Boundary Value Analysis)

## いつ使うか (適用条件)

同値分割で洗い出した各クラスに、範囲の端点 (閾値・サイズ制限・最小/最大) があるとき。実装は境界の位置を誤りやすい (`<` と `<=` の取り違え、off-by-one) ため、境界そのものを重点的にテストする。同値分割とセットで使うのが基本。

## 導出手順

1. 同値分割のクラス表から、各クラスの境界 (閾値) を洗い出す
2. 各境界について、2値法か3値法のどちらかを選ぶ (規約として明記して統一する):
   - **2値法 (on-point / off-point)**: 境界値そのもの (on-point) と、隣接パーティションに属する最も近い値 (off-point) の2点
   - **3値法 (min-, min, min+ / max-, max, max+)**: 境界の直前・境界・直後の3点
3. **off-point の決め方を場当たりにしない**: 整数境界は ±1 が off-point になる。float/実数境界では、仕様が定める分解能 (例: 金額なら最小通貨単位 = 0.01) を off-point の刻み幅として使う。分解能が仕様にない場合は、実装が扱う最小の有効差分 (浮動小数点の丸め単位ではなく、ドメイン上意味のある最小差分) を明示的に決めてから使う。「境界値 + 0.01」のような値を都度その場で選ばない
4. 閉区間・開区間の扱いを明示する: 「以上/以下 (閉区間)」であれば on-point は含まれる側、「未満/超 (開区間)」であれば on-point は境界の外側の隣接値になる
5. 境界一覧表を作る: `境界 × on-point × off-point × 期待結果`

### 境界一覧表の書式例 (合計金額が1000円以下なら送料無料、分解能=1円)

| 境界 | on-point | off-point | 期待結果 |
|---|---|---|---|
| 合計 <= 1000 (無料の上限) | 1000 | 1001 | on: 無料 / off: 有料 |
| 合計の下限 | 0 | -1 (仕様上到達不可なら対象外) | 0: 無料 |

## 実装パターン

言語非依存の原則: 境界一覧表の各行を1テストケースに対応させ、表をコメントとして残す。on-point と off-point は必ずペアで書き、片方だけ書かない。

```python
# boundary table: free-shipping threshold = 1000 (resolution: 1 yen)
@pytest.mark.parametrize("total,expected", [
    (1000, "free"),    # on-point
    (1001, "charged"),  # off-point
])
def test_shipping_fee_boundary(total, expected):
    ...
```

## 科学的根拠

- ISTQB Foundation Level Syllabus v4.0 (2023), §4.2.2 "Boundary Value Analysis" — 境界値分析の定義、2値法/3値法の区別、境界値が欠陥の集中する箇所であるという根拠づけを裏付ける
- Myers, Sandler, Badgett, "The Art of Software Testing", 3rd Edition (Wiley, 2011) — 境界値分析の古典的定式化 (同値分割の境界に着目する手順) を裏付ける
- ISO/IEC/IEEE 29119-4:2021 (2nd edition), "Software and systems engineering — Software testing — Part 4: Test techniques" — 境界値分析をテスト技法として国際規格上に定義していることを裏付ける
- Reid, S. (1997), "An empirical analysis of equivalence partitioning, boundary value analysis and random testing", Proceedings of the 4th International Software Metrics Symposium (IEEE METRICS) — 実運用の航空機システム (Ada, 約2万行) を対象にした実証研究で、境界値分析が同値分割・ランダムテストより欠陥検出力が高かったと報告されていることを複数の独立した検索結果で確認した (具体的な検出率の数値は一次情報 [IEEE Xplore doc 637166] の本文を取得できず確認できなかったため記載しない)

## 限界と誤用

- 境界が仕様に明記されていない場合 (暗黙の制限) は、境界そのものを見つける工数がかかる
- 複数入力が絡む複合境界 (例: 2つのパラメータの和に上限がある) は単純な on/off の組合せでは網羅できず、追加の設計が要る
- off-point の刻み幅を場当たりに決めると、テストが「たまたま」失敗/成功するだけの意味のない境界になる → 分解能を明示してから選ぶ (導出手順3)
