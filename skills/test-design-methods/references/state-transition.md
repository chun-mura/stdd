# 状態遷移テスト (State Transition Testing)

## いつ使うか (適用条件)

ソフトウェアの挙動が現在の状態と呼び出し順序に依存するとき。ステートマシンでモデル化できるシステム (接続・セッション・トランザクションのライフサイクル、UIフロー、ジョブステータスの推移) に適用する。**テスト観点として「状態依存」「順序依存」「冪等性」が挙がったとき、この手法の適用を検討する** (aidd:test-perspectives を併用している場合はその観点出力が入力になる)。

単一の状態遷移を持つシステムや、状態が実装詳細でしかない場合は不要。

## 導出手順

1. 対象システムの**状態をすべて列挙する** (例: Open, Waiting, Processing, Closed, Error)
2. 各状態から遷移可能なイベント (メソッド呼び出し・ユーザアクション・タイムアウト) を列挙し、遷移先状態を決める
3. **無効遷移も表に含める**: 定義されていない状態×イベントの組合せ (例: Closed 状態で再開イベント) は仕様で「例外を発生させる」または「無視する」かを確定させる
4. **カバレッジ水準を選ぶ** — 複数の選択肢がある:
   - **全状態** (state coverage): すべての状態が少なくとも1回の遷移で到達される
   - **全遷移** (transition coverage / 0-switch): 有効遷移をすべて1回は実行する。通常はこれが must
   - **遷移ペア** (transition pair coverage / 1-switch, N-switch): ある状態から出た遷移と、次の状態からの遷移をペアで実行する。状態依存バグ (「前の操作がこの操作に与える影響」) の疑いがあるとき選ぶ
5. 遷移表を作る: `現在状態 × イベント × 期待次状態` (または期待例外)

### 状態遷移表の書式例 (ファイル操作: Open → Write/Close → Closed)

| 現在状態 | イベント | 期待次状態 | 備考 |
|---|---|---|---|
| Initial | open() | Open | |
| Open | write(data) | Open | 状態変わらず |
| Open | close() | Closed | |
| Closed | write(data) | — | 例外: IllegalStateException |
| Closed | close() | — | 例外: IllegalStateException |
| Open | timeout | Closed | エラーハンドリング |

## 実装パターン

言語非依存の原則: 遷移表の各行を1テストケースに対応させ、表をコメントとして残す。無効遷移も同様にテストケース化する。

```python
# state transition table: File operations
# see references/state-transition.md for design
@pytest.mark.parametrize("state,event,expected_next_state,should_raise", [
    ("Open", "write", "Open", False),      # valid: write in Open
    ("Open", "close", "Closed", False),    # valid: transition to Closed
    ("Closed", "write", None, True),       # invalid: write in Closed raises
    ("Closed", "close", None, True),       # invalid: double close raises
])
def test_file_state_transitions(state, event, expected_next_state, should_raise):
    ...
```

JS/TS では同様に `test.each` で実装し、表との対応を保つ。

## 科学的根拠

- ISTQB Certified Tester Foundation Level Syllabus v4.0 (2023), §4.2.4 "State Transition Testing" — 状態遷移テストの定義、テスト手法としての標準的手順、状態・イベント・遷移の概念を裏付ける
- Chow, T.S. (1978) "Testing Software Design Modeled by Finite-State Machines", IEEE Transactions on Software Engineering, vol. 4, no. 3, pp. 178-187 — 有限状態機械による設計テストの原典的論文。N-switch カバレッジなど遷移ペア以上の多段階カバレッジ戦略の理論的基礎を裏付ける

## 限界と誤用

- **状態爆発**: 複数の独立した状態変数がある場合、状態の直積が急速に大きくなる。その場合は状態を抽象化する (例: 細粒度な状態を粗粒度な「フェーズ」に統合)、または独立パラメータが多い場合はペアワイズテスト (`pairwise.md`) と併用する検討をする
- **実装詳細と混同**: 状態がコード内の実装詳細でしかなく、ユーザーが観測可能な振る舞いと対応していない場合、テストの保守性と価値が低い。仕様レベルで定義された状態かどうか確認する
- **遷移の遺漏**: 状態図を作成する際、稀な遷移 (エラーハンドリング、タイムアウト) を見落としやすい。テスト前に遷移表の完全性を設計レビューで確認する
