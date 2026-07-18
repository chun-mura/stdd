# Token Footprint Reduction Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** stdd の実行時トークン使用量を削減しつつ、テスト設計の導出規律を維持する。

**Architecture:** 詳細証跡と共通実装規約を docs に分離し、skills は最小ルーターと手法固有規則にする。commands は必要な入力だけを正規化して扱い、設計書の重複を ID 参照へ置換する。

**Tech Stack:** Markdown、POSIX shell、jq、GitHub Actions。

## Global Constraints

- 既存の手法選択、必須の否定ケース、出典追跡を削除しない。
- skills または commands を変更したら README、CHANGELOG、plugin version を更新する。
- 変更前に失敗する資産検査を作成し、変更後に通す。

---

### Task 1: 資産検査を追加する

**Files:**
- Create: `tests/test_plugin_assets.sh`

- [ ] **Step 1: 失敗する検査を書く**

`docs/evidence.md`、`docs/test-implementation-conventions.md`、共通規約参照、圧縮済み command の要件を `grep` で検査する。

- [ ] **Step 2: 検査が失敗することを確認する**

Run: `bash tests/test_plugin_assets.sh`

Expected: `docs/evidence.md` がないため FAIL。

- [ ] **Step 3: 最小の資産変更を実装する**

Task 2〜4 の assets を作成する。

- [ ] **Step 4: 検査が通ることを確認する**

Run: `bash tests/test_plugin_assets.sh`

Expected: PASS。

### Task 2: skills と reference を最小化する

**Files:**
- Create: `docs/evidence.md`, `docs/test-implementation-conventions.md`
- Modify: `skills/test-design-methods/SKILL.md`, `skills/test-design-methods/references/*.md`, `skills/test-suite-evaluation/SKILL.md`, `skills/test-suite-evaluation/references/*.md`
- Delete: `skills/test-design-methods/references/sources.md`, `skills/test-suite-evaluation/references/sources.md`

- [ ] **Step 1:** 出典全文を `docs/evidence.md` へ移す。
- [ ] **Step 2:** 反復する実装例を共通規約へ集約する。
- [ ] **Step 3:** 各 skill と reference を手法選択・導出規則・手法固有の注意だけに圧縮する。

### Task 3: commands と成果物形式を圧縮する

**Files:**
- Modify: `commands/test-design.md`, `commands/test-design-sync.md`, `commands/mutation-check.md`

- [ ] **Step 1:** `/test-design` を必要 reference のみの読込と ID 参照形式の出力にする。
- [ ] **Step 2:** `/test-design-sync` を `rg` による候補絞込み後、曖昧なケースのみ精査する流れにする。
- [ ] **Step 3:** `/mutation-check` を survivor の正規化・重複排除・必要時の原文参照にする。

### Task 4: 配布メタデータと検証を更新する

**Files:**
- Modify: `README.md`, `CHANGELOG.md`, `.claude-plugin/plugin.json`, `.github/workflows/validate.yml`

- [ ] **Step 1:** README の運用ルールと成果物形式を更新する。
- [ ] **Step 2:** version を 0.6.0 に上げ、CHANGELOG に圧縮内容を記録する。
- [ ] **Step 3:** CI から assets 検査を実行する。
- [ ] **Step 4:** shell 検査、JSON 検査、git diff --check を実行する。
