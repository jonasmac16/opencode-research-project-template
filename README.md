# OpenCode scientific data-analysis project template

A self-contained, **project-local** OpenCode baseline for scientific data-analysis and data-processing repositories, especially bioinformatics, computational biology, mathematical biology, biostatistics, systems biology, and related quantitative research.

The template supports Python, R, Julia, Markdown/notebooks, Apptainer, DataLad, and Git initially. A new project is expected to specialize that baseline and prune programming-language/domain support it does not need.

Nothing in this template needs to be installed in `~/.config/opencode/`, and the included helpers never modify global OpenCode configuration.

## Initialization order

For a new project created from this template, use:

```text
/init-analysis
/init
/review-init    # optional
```

`/init-analysis` runs first because it establishes the project's scientific identity and language choices before the generic `/init` pass simplifies and specializes `AGENTS.md`.

The two initialization steps deliberately have different ownership:

```text
.opencode/project-profile.md   /init-analysis owns scientific + language identity
AGENTS.md                      /init owns repository-operational instructions
```

This prevents scientific context from being repeatedly compressed into generic coding guidance.

## Layout

```text
AGENTS.md                         baseline operational/safety instructions; refine with /init
opencode.json                    active project-local OpenCode config
.opencode/
  project-profile.md             canonical scientific/language profile; refine with /init-analysis
  agents/analysis-reviewer.md
  commands/
    init-analysis.md
    review-init.md
    checkpoint.md
    inspect-data.md
    review-analysis.md
  plugins/analysis-compaction.js
  skills/
    data-analysis/
    data-validation/
    reproducibility/
    analysis-review/
    scientific-analysis/
  profiles/                      inactive V1/V2 config + plugin source profiles
  bin/                           OpenCode project helpers only
    opencode-data
    check-environment.sh
    select-profile.sh
  .gitignore                     ignores transient session state and profile backups
docs/DECISIONS.md                durable scientific/analysis decisions
```

A top-level `bin/` directory is intentionally not part of the template. Downstream projects remain free to use `bin/` for actual analysis executables such as `bin/run-analysis` or `bin/generate-report`.

## Start a new project

Use this repository as a GitHub template, clone/copy it, or create a new repository from its contents.

The checked-in default targets stable/current OpenCode V1 (`opencode`). In the new project root:

```sh
./.opencode/bin/check-environment.sh
./.opencode/bin/opencode-data
```

Then inside OpenCode run:

```text
/init-analysis
```

The command should inspect repository evidence first and then ask only consequential unresolved questions. Before pruning support it asks you to confirm:

- primary programming language(s);
- supporting language(s) and their allowed role;
- unused Python/R/Julia support to remove;
- scientific domain reference(s) to retain;
- unresolved scientific facts whose wrong interpretation could invalidate the analysis.

It writes `.opencode/project-profile.md`, then specializes project-local skills/configuration. For example, an R-first bioinformatics project with a small Python preprocessing layer might retain R + Python, remove Julia support, and retain bioinformatics + biostatistics scientific references.

After `/init-analysis` completes, run:

```text
/init
```

`/init` should then focus `AGENTS.md` on concrete repository operations: entry points, directory layout, test/lint/type commands, DataLad inputs, Apptainer invocation, outputs, expensive operations, and project-specific operational gotchas. It should treat `.opencode/project-profile.md` as authoritative rather than duplicating the scientific profile.

Optionally run:

```text
/review-init
```

This checks for contradictions between the two initialization layers and for language/configuration that should have been pruned.

## Scientific context

The `scientific-analysis` skill separates four forms of correctness:

1. computational correctness;
2. numerical correctness;
3. statistical validity;
4. scientific validity.

Its general reference covers scientific grain, provenance, units, stochasticity, and the distinction between observation and inference. Domain references are initially included for:

- bioinformatics / genomics / omics;
- computational and systems biology;
- mathematical / mechanistic biology;
- biostatistics and experimental design.

`/init-analysis` can remove domain references confirmed irrelevant to the project. The general scientific-computing reference is retained.

## Language specialization

The template initially contains lazy references for Python, R, and Julia. `/init-analysis` classifies languages as:

- **primary** — main implementation/analysis language;
- **supporting** — retained for a constrained existing role;
- **unused** — removed from the project's OpenCode analysis support after confirmation.

Pruning an unused language removes its language reference and any project-local LSP configuration specific to it. The environment checker infers enabled language support from the remaining reference files, so it stops warning about pruned languages automatically.

This specialization is primarily about behavioral precision, not only token count: an R-only analysis should not invite an agent to add a Python or Julia sidecar merely because the generic template supported those languages.

## Project-profile loading

For OpenCode V1/current, `opencode.json` loads `.opencode/project-profile.md` as an additional project instruction.

Current OpenCode V2 parses the `instructions` field but does not resolve configured instruction files. The V2 project-local plugin therefore injects `.opencode/project-profile.md` into primary and compaction model context. `AGENTS.md` also contains a short fallback rule directing scientific work to the canonical profile.

The profile should stay concise, normally below 100 lines. Put durable rationale/history in `docs/DECISIONS.md` rather than turning the profile into a notebook or transcript.

## Project-local configuration

OpenCode loads `opencode.json` from the project root and project extensions from `.opencode/`. The template modifies only this repository.

The checked-in default targets stable/current V1:

- automatic compaction and old-tool-output pruning enabled;
- 20k compaction reserve;
- project skills allowed;
- external-directory access asks for approval;
- LSP permission enabled where the runtime supports it;
- R `languageserver` declared initially because R is part of the unspecialized template;
- `.opencode/project-profile.md` loaded as project instructions.

Version-specific config and compaction-plugin sources live under `.opencode/profiles/` and are not loaded automatically. Select one only for this repository:

```sh
./.opencode/bin/select-profile.sh v1
# or
./.opencode/bin/select-profile.sh v2
```

The selector replaces only this repository's `opencode.json` and `.opencode/plugins/analysis-compaction.js`, backing up previous local copies under ignored `.opencode/backups/`.

If `/init-analysis` prunes language-specific configuration, it updates both inactive profile JSON files as well as the active config so later profile switching preserves the specialization.

## Token/context strategy

- `AGENTS.md` contains durable operational invariants rather than language/domain manuals.
- `.opencode/project-profile.md` contains only project-specific scientific/language facts.
- Five skills are project-local and loaded on demand.
- Language/tool and scientific-domain detail lives in lazy reference files.
- `/init-analysis` can physically prune irrelevant language/domain references.
- Automatic compaction is enabled.
- `.opencode/plugins/analysis-compaction.js` preserves analysis/provenance/scientific continuation facts.
- `/review-analysis`, `/inspect-data`, and `/review-init` use isolated child contexts.
- `/checkpoint` writes concise transient resume state to ignored `.opencode/session-state.md`.
- Durable scientific decisions belong in `docs/DECISIONS.md`.
- No generic memory database or MCP servers are enabled by default.

## LSP

For OpenCode V1/current (`opencode`), `./.opencode/bin/opencode-data` sets `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` only for that process. It does not change your shell profile or global OpenCode settings.

The unspecialized config includes R `languageserver`; OpenCode's available built-in servers may serve Python/Julia when supported and installed. `/init-analysis` removes project-local language-specific LSP configuration for confirmed unused languages.

LSP is for navigation and advisory diagnostics. Project lint/type/test/compiler commands remain authoritative, especially when analysis executes inside Apptainer while language servers run on the host.

OpenCode V2 currently accepts LSP configuration but does not provide the LSP runtime/tool. See `docs/LSP.md`.

## External data and containers

The baseline assumes:

- external DataLad datasets are read-only inputs by default;
- only necessary annexed content is retrieved;
- exact dataset revisions are recorded when relevant;
- analyses use documented Apptainer execution rather than silently modifying the host;
- container definitions maintained in another repository are a separate writable boundary.

## Retrofitting an existing repository

Migration tooling is intentionally not included on the template `template` branch. Use the companion `migration-tools` branch to retrofit this configuration into an existing project without copying migration utilities into every new repository.
