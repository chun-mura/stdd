# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A Claude Code **plugin repository** (not an application). It ships a catalog of evidence-based test
design methods (equivalence partitioning, boundary value analysis, decision tables, state transition
testing, pairwise, PBT, fuzz) plus test-suite quality evaluation (coverage-strength hierarchy, mutation
testing), packaged as Claude Code skills, commands, and reference docs consumed at runtime by other
Claude Code sessions — not as a library imported by test code.

**The plugin itself is unvalidated in production**: README.md states explicitly "このプラグインは実プロジェクトでの検証が未実施である" (no real-project validation has been done yet). Treat behavioral claims about the skills/commands as untested; treat the cited evidence (docs/evidence.md) as the only thing that's actually verified.

## Repository layout

- `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json` — plugin manifest and marketplace entry. `plugin.json.version` is the single source of truth for the plugin version.
- `skills/test-design-methods/`, `skills/test-suite-evaluation/` — auto-triggered skills, each with a `SKILL.md` (routing table) and `references/*.md` (one method per file: selection criteria + derivation rules, no worked examples).
- `commands/` — `/stdd:test-design`, `/stdd:mutation-check`, `/stdd:test-design-sync` (slash-command prompts).
- `docs/evidence.md` — the only place with citations; see "Evidence rule" below.
- `tests/test_plugin_assets.sh` — invariant checks over the repo's own files (not application tests).
- `.github/workflows/validate.yml` — CI.

## Architecture: how the two skills connect

`test-design-methods` fires **before** test code is written (turning perspectives into concrete cases
via a derivation table). `test-suite-evaluation` fires **after** a suite exists (judging whether green
tests / coverage numbers can be trusted). They form a loop, not two independent skills:

`test-suite-evaluation` (mutation-testing.md, coverage-criteria.md) surfaces **surviving mutants** and
**unexecuted branches** → those become the input list that `test-design-methods`' method-selection flow
(the "コード特性 → 手法" table in `skills/test-design-methods/SKILL.md`) consumes to derive the missing
cases. `commands/mutation-check.md` implements this loop directly: it runs mutation testing, classifies
survivors (insufficient test / equivalent mutant / unreachable code), and only "insufficient test"
survivors get cross-referenced against `docs/test-design/*.md`; unmatched ones are routed into the
test-design-methods selection flow to derive new `D-ID` rows.

`coverage-criteria.md` encodes a **corrected** strength hierarchy: `statement ⊂ branch ⊂ MC-DC`, with
condition coverage explicitly **outside** this chain (it does not subsume branch coverage — this was a
real bug fixed in v0.5.1; don't reintroduce the older "statement ⊂ branch ⊂ condition ⊂ MC-DC" claim).

## Operating rules (README "運用ルール") that gate every asset change

These are enforced partly by convention, partly by CI — know which:

1. One file, one concern; state "when to use this" at the top of the file.
2. **2-use rule**: only prompts/patterns actually used 2+ times get promoted into a permanent asset (the two feedback-loop commands, `mutation-check` and `test-design-sync`, are explicit, documented exceptions).
3. **Enforced by CI**: any change under `commands/` or `skills/` must ship together with (a) a version bump in `.claude-plugin/plugin.json`, and (b) updates to both `README.md` and `CHANGELOG.md` in the same diff. `validate.yml` fails the build otherwise.
4. No duplication: functionality already owned by superpowers/aidd/trailofbits must be a pointer, not a reimplementation (see README "併用推奨": TDD process → superpowers, perspective generation → aidd, PBT how-to → trailofbits-property-based-testing).
5. No passive docs: knowledge must live in an auto-triggered skill or an enforced hook, not a markdown file nobody reads.
6. **Evidence rule**: adding or changing a method requires registering a verified citation in `docs/evidence.md` (organized by method family: EP/BVA, Decision/state transition, Pairwise/PBT/fuzz, Coverage/mutation). Ordinary `references/*.md` files hold only derivation rules and a one-line citation key pointing at `docs/evidence.md` — do not re-embed citation prose into a reference file.
7. **Design-doc minimization**: the derivation table (`D-ID` rows: input/condition → expected result) is the source of truth. The case table in `docs/test-design/*.md` only references `D-ID`s plus `ID / 導出行 ID / 優先度 / 状態` — never duplicate inputs/expected results into the case table.

## Commands and how to verify a change

```bash
bash tests/test_plugin_assets.sh   # repo-invariant checks (see below) — run before claiming any asset change is done
jq -e . .claude-plugin/plugin.json .claude-plugin/marketplace.json   # manifest JSON validity
```

`tests/test_plugin_assets.sh` checks structural invariants, e.g.: `docs/evidence.md` exists and no
stale files from prior refactors have reappeared (`docs/superpowers`,
`docs/test-implementation-conventions.md`, `skills/*/references/sources.md`); every `references/*.md`
points at `docs/evidence.md`; specific phrases exist in `SKILL.md`/`commands/*.md` (used as change
markers — e.g. `experimental` in both `commands/test-design-sync.md` and `README.md`); specific
citations exist in `docs/evidence.md`; and — **it hardcodes an exact expected version string** via
`jq -e '.version == "0.6.2"' .claude-plugin/plugin.json`.

**Known gotcha**: that hardcoded version check has gone stale before (a past release bumped
`.claude-plugin/plugin.json` without updating this string, so `bash tests/test_plugin_assets.sh` failed
on a clean checkout of `main` until fixed). When you bump the version, remember to update the hardcoded
string in `tests/test_plugin_assets.sh` in the same commit.

CI (`.github/workflows/validate.yml`, triggered on push to `main` and on PRs) runs, in order: manifest
JSON validation, `tests/test_plugin_assets.sh`, a check that any `commands/`/`skills/` diff includes a
`.claude-plugin/plugin.json` version-field change (operating rule 3), and a check that such a diff also
touches both `README.md` and `CHANGELOG.md` (operating rule 3). All four must pass for a PR to be
mergeable.

## When editing an asset

1. Edit the skill/command/reference file.
2. Update `docs/evidence.md` if a method's claim or citation changed (rule 6).
3. Bump `.claude-plugin/plugin.json` `version`, and update the hardcoded version string in
   `tests/test_plugin_assets.sh` if it references one.
4. Update `README.md` (index table + relevant prose) and add a `CHANGELOG.md` entry — same commit/PR.
5. Run `bash tests/test_plugin_assets.sh` and the `jq -e .` manifest checks locally before pushing.
