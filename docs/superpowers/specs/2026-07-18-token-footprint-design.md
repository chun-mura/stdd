# Token Footprint Reduction Design

## Goal

テスト設計の導出規律・根拠の追跡可能性・既存コマンドの成果物を保ちつつ、通常実行時に読む指示文と再読込される設計書を小さくする。

## Chosen approach

詳細な書誌と共通の実装例を `docs/` に退避し、skills は選択と導出に必要な規則だけを持つ。commands は対象を先に絞り、中間結果と生成設計書を ID 参照で正規化する。これは出典だけを退避する案、コマンドだけを最適化する案よりも、固定入力と実行時出力の双方を削減できるため採用する。

## Boundaries

- `skills/` は自動発動時に必要な選択基準・導出規則のみを保持する。
- `docs/evidence.md` は検証済み出典の保管庫、`docs/test-implementation-conventions.md` は共通の実装規約とする。通常の導出では読まない。
- `commands/` は必要な reference だけを読むよう指示し、調査対象・mutation・設計書を圧縮形式で扱う。
- `docs/test-design/` の成果物は導出表を正本とし、テストケース表は導出行 ID を参照する。

## Invariants

- 無効入力、否定側のルール、無効遷移、制約を持つ組合せを省略しない。
- 全 reference の出典を `docs/evidence.md` で追跡可能にする。
- `/stdd:test-design`、`/stdd:test-design-sync`、`/stdd:mutation-check` の用途と安全確認要件を維持する。
- assets 変更に伴い README、CHANGELOG、plugin version を更新する。

## Verification

JSON manifest の妥当性、出典の集約先、共通規約への参照、各 command の圧縮方針と成果物形式を `tests/test_plugin_assets.sh` で検査し、既存 CI と同じ JSON 検査も実行する。
