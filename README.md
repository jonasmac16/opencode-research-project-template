# OpenCode data-analysis project template

A self-contained, **project-local** OpenCode baseline for data-analysis and data-processing repositories using Python, R, Julia, Markdown/notebooks, Apptainer, DataLad, and Git. A project may use only a subset.

Nothing in this template needs to be installed in `~/.config/opencode/`, and the included helpers never modify global OpenCode configuration.

## Layout

```text
AGENTS.md                         baseline project instructions; refine with /init
opencode.json                    active project-local OpenCode config
.opencode/
  agents/analysis-reviewer.md
  commands/
    checkpoint.md
    inspect-data.md
    review-analysis.md
  plugins/analysis-compaction.js
  skills/
    data-analysis/
    data-validation/
    reproducibility/
    analysis-review/
  profiles/                      inactive V1/V2 config + plugin source profiles
  bin/                           OpenCode project helpers only
    opencode-data
    check-environment.sh
    select-profile.sh
  .gitignore                     ignores transient session state and profile backups
docs/DECISIONS.md                durable analysis/scientific decisions
```

A top-level `bin/` directory is intentionally not part of the template. If an analysis project later needs executable pipeline commands such as `bin/run-analysis` or `bin/generate-report`, that namespace remains available for the project itself.

## Start a new project

Use this repository as a GitHub/Git template, copy it, or clone it and replace its Git history.

The checked-in default targets stable/current OpenCode V1 (`opencode`). Once it is the root of the analysis project:

```sh
./.opencode/bin/check-environment.sh
./.opencode/bin/opencode-data
```

Inside OpenCode:

```text
/init
```

Review the resulting `AGENTS.md`. `/init` should add the actual languages, entry points, test/lint/type commands, DataLad inputs, Apptainer invocation, output locations, expensive operations, and project-specific scientific assumptions while retaining applicable baseline rules.

If using the OpenCode V2 beta, first run:

```sh
./.opencode/bin/select-profile.sh v2
opencode2
```

The selector changes only files inside this repository.

To retrofit this setup into an existing repository, use the companion `migration-tools` branch rather than copying migration tooling into projects created from `main`.

## Project-local configuration

OpenCode loads `opencode.json` from the project root and project extensions from `.opencode/`. Project configuration has higher precedence than ordinary global configuration for matching settings, but it does not rewrite the global file.

The checked-in default targets stable/current V1:

- automatic compaction and old-tool-output pruning enabled;
- 20k compaction reserve;
- project skills allowed;
- external-directory access asks for approval;
- LSP permission enabled where the runtime supports the LSP tool;
- R `languageserver` declared for `.R`, `.r`, `.Rmd`, and `.rmd` files.

Version-specific config and compaction-plugin sources are kept under `.opencode/profiles/` and are **not loaded automatically**. Select one only for this repository:

```sh
./.opencode/bin/select-profile.sh v1
# or
./.opencode/bin/select-profile.sh v2
```

This replaces only this repository's `opencode.json` and `.opencode/plugins/analysis-compaction.js`, backing up the previous local copies under ignored `.opencode/backups/` first.

## Token/context strategy

- `AGENTS.md` contains durable project-level invariants rather than a large language manual.
- Four skills are discovered project-locally and loaded on demand.
- Python/R/Julia/LSP/DataLad/Apptainer detail lives in lazy reference files under those skills.
- Automatic compaction is enabled.
- `.opencode/plugins/analysis-compaction.js` adds analysis/provenance facts that should survive compaction.
- `/review-analysis` and `/inspect-data` use isolated review/subtask contexts.
- `/checkpoint` writes concise transient resume state to `.opencode/session-state.md`; that file is ignored by Git.
- Durable scientific decisions belong in `docs/DECISIONS.md`.
- No generic memory database or MCP servers are enabled by default.

## LSP

For OpenCode V1/current (`opencode`), `./.opencode/bin/opencode-data` sets `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` for that process only. It does not change your shell profile or global OpenCode settings.

The project config adds R `languageserver`; OpenCode's available built-in servers can still serve Python/Julia when supported and installed. LSP is for navigation and advisory diagnostics. Project lint/type/test/compiler commands remain authoritative.

OpenCode V2 currently accepts and preserves LSP configuration but does not start language servers or expose an LSP tool. See `docs/LSP.md`.

## External data and containers

The baseline assumes:

- external DataLad datasets are read-only inputs by default;
- only necessary annexed content is retrieved;
- exact dataset revisions are recorded when relevant;
- analyses use documented Apptainer execution rather than silently modifying the host;
- container definitions maintained in another repository are a separate writable boundary.

## Customization

Keep generally useful project behavior in the four existing skills and their references. Add domain/project-specific skills under `.opencode/skills/`, for example:

```text
.opencode/skills/validate-cohort-definition/
.opencode/skills/build-publication-figures/
```

Avoid adding a skill merely to store facts that belong in `AGENTS.md`, code, schemas, or `docs/DECISIONS.md`.
