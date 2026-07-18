# ファジング (Fuzz Testing)

## いつ使うか (適用条件)

パーサ・デシリアライザ・ファイルデコーダ・ネットワークプロトコルハンドラなど、信頼できない外部入力を読むコード。クラッシュ・ハング・メモリ安全性違反が主目的で、機能の正確さ (出力値の検証) は example-based (同値分割・境界値分析・PBT) の領分という選び分け。

## 導出手順

1. 対象関数の入力面 (attack surface) を特定: ファイルフォーマット、ネットワークパケット構造、プロトコル状態図など
2. ハーネス (harness) を作る: ランダム/変異した入力バイト列 → 対象関数 → クラッシュ検出
3. カバレッジガイド付きファザーで実行 (libFuzzer / AFL++ / 言語組込み)
4. クラッシュを見つけたら、最小化 (minimization) して回帰テストのコーパスに昇格

## 実装パターン

言語非依存の原則: ハーネスは決定的 (グローバル状態なし)・1入力1実行・標準入力から読む設計。

```python
# Fuzzing harness for JPEG decoder
import atheris
import sys
from jpeg_decoder import decode

@atheris.instrument_func
def fuzz_jpeg(data: bytes):
    try:
        decode(data)
    except Exception:
        pass  # Expected: decoder must not crash on invalid input

atheris.Setup(sys.argv, fuzz_jpeg)
atheris.Fuzz()
```

Go ならネイティブ `go test -fuzz=FuzzName` が可能。ツール選択は環境・言語・統合容易性で決める。

## 科学的根拠

- Miller, B. P., Fredriksen, L., & So, B. (1990), "An Empirical Study of the Reliability of UNIX Utilities", Communications of the ACM 33(12) — fuzzing の起源。約90個の UNIX ユーティリティを検査し、約25% がランダム入力で**クラッシュ**した。基本的なメモリ安全性・入力検証の欠陥が広く存在することを実証。
- Seacord, R. C. (2013), "Secure Coding in C and C++", 2nd Edition (Addison-Wesley) — メモリ安全性違反の分類と、ファジングの検出効果。
- Google OSS-Fuzz (2016–) — 継続的ファジング基盤。Google の公表 (2023年2月時点) で、1,000 以上のオープンソースプロジェクトから累積 8,900 以上の脆弱性・28,000 以上のバグを検出。実運用での効果を実証。

## 限界と誤用

- **オラクル問題**: クラッシュ・タイムアウト以外の誤り (論理エラー) は検出できない。アサーション・サニタイザ (AddressSanitizer / MemorySanitizer) と併用して緩和
- CI での実行時間コスト: フルスイートのファジングは多数のコアと時間を要する。回帰用の最小コーパス + 定期フルスイート (夜間・休前) の2層運用が典型
- 構造化入力 (JSON / Protocol Buffer など) には辞書・文法ベースの変異が必要。ランダムバイト列単体では到達不可能な境界を見つけにくい
