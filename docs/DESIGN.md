# Design

This repository is intentionally project-local. It does not require or modify `~/.config/opencode/`.

## 1. `AGENTS.md`: project baseline plus `/init` specialization

The checked-in baseline contains safety, correctness, provenance, and reproducibility invariants. Run `/init` in the repository so OpenCode adds concrete project facts and commands.

## 2. `.opencode/skills`: conditional workflows

Four core skills are discoverable within this repository:

- `data-analysis`
- `data-validation`
- `reproducibility`
- `analysis-review`

Their bodies load on demand. Language/tool details are kept in references and should be loaded only when relevant, avoiding context cost for Python, R, Julia, DataLad, Apptainer, or LSP guidance that a task does not need.

## 3. Durable vs transient state

- `docs/DECISIONS.md`: version-controlled, non-obvious scientific/analysis decisions.
- `.opencode/session-state.md`: transient resume state written by `/checkpoint` and ignored by Git.
- Git: code/project history.
- DataLad: dataset identity/content provenance.
- Apptainer/container repository: execution-environment identity.

This avoids introducing a generic memory database as a second source of truth.

## 4. Context reduction

- automatic OpenCode compaction;
- analysis-aware compaction hook;
- lazy skill/reference loading;
- isolated review/data-inspection commands;
- LSP-assisted targeted navigation where supported;
- no MCP servers enabled by default.

## 5. Configuration scope

`opencode.json`, `.opencode/agents`, `.opencode/commands`, `.opencode/plugins`, and `.opencode/skills` are all stored in the analysis repository. They affect this project when OpenCode is run within it. The template never edits global OpenCode files.

## 6. Helper namespace

OpenCode-specific helper executables and inactive profile sources live under `.opencode/`. The template intentionally leaves top-level `bin/` unused so downstream analysis projects can reserve it for their own pipeline/application commands. Migration utilities do not belong on the template `main` branch because GitHub template creation would copy them into every downstream repository.
