# Changelog

## 0.1.0 - 2026-07-17

初期スキャフォールド。プラグイン骨格 (plugin.json / marketplace.json / README / CI) のみで資産は未収録。

- `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`: プラグイン定義 (dependencies なしのスタンドアロン構成、運用ルール4に基づき superpowers/aidd へはポインタ参照のみ)
- `README.md`: 棲み分け定義・運用ルール5原則・併用推奨を記載
- `.github/workflows/validate.yml`: uidd と同じ検証 CI を導入
