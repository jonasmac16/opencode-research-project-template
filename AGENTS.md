# Baseline instructions for this data-analysis project
These baseline rules apply to this repository. Use `/init` to refine this file with concrete project facts and commands while preserving applicable safety, provenance, and reproducibility rules.

## Work from evidence

- Inspect the repository before assuming its language, layout, environment, data locations, workflow, or output conventions.
- Projects may use Python, R, Julia, shell, Markdown, or a subset of them.
- Prefer existing project commands, task runners, configuration, and documented workflows over introducing new mechanisms.
- Make the smallest change that solves the requested problem; keep analysis changes separate from unrelated refactors.
- Validate expensive work on a representative subset, dry run, focused test, or smoke test before running full data.

## Model the analysis workflow

When relevant, identify:

1. source inputs;
2. intermediate data;
3. analysis/processing code;
4. generated results;
5. figures, tables, and reports;
6. environment/container identity;
7. provenance information;
8. executable entry points.

Do not infer semantic meaning from filenames when code, metadata, schemas, or documentation can establish it.

## Protect data

Treat source data as immutable unless modification is explicitly requested.

- Do not overwrite raw/source data.
- Do not move, rename, delete, drop, save, or commit external dataset content merely to simplify a task.
- Do not copy large source datasets into the analysis repository unless this is an established project convention.
- Avoid committing large derived data, container images, transient caches, or generated artifacts unless the project explicitly tracks them.
- Before destructive data operations, obtain explicit authorization.

## External DataLad datasets

Datasets consumed by the analysis may be outside the current worktree.

- Treat external DataLad datasets as read-only inputs by default.
- Inspect dataset state before assuming annexed content is locally present.
- Retrieve only content needed for the current task; do not recursively obtain an entire dataset by default.
- Preserve enough information to identify the exact dataset revision used.
- Do not `save`, `drop`, `uninstall`, remove, or otherwise mutate an external dataset unless explicitly requested.
- Do not add an external dataset to the current repository merely because the analysis consumes it.

## Reproducible environments and Apptainer

Prefer the environment documented by the project.

- When an Apptainer container is the expected environment, run analysis commands through it rather than modifying the host environment.
- Do not install host or container packages interactively merely to make a command work unless dependency modification is part of the task.
- Do not silently substitute another image or the host environment.
- Record/report container identity when reproducibility matters.
- Container definitions maintained in another repository are a separate project; do not modify that repository as a side effect of analysis work.
- Do not rebuild containers automatically unless required by the task.

## Reproducibility

- Make important parameters explicit.
- Seed stochastic work when results depend on randomness.
- Avoid machine-specific absolute paths in committed code; prefer project-root-relative paths, configuration, CLI arguments, or environment variables.
- Do not rely on hidden interactive state in Python, R, Julia, notebooks, or IDE sessions.
- Avoid undocumented manual preprocessing steps.
- Preserve existing provenance and metadata mechanisms.
- When changing a pipeline, consider whether cached or previously generated outputs are invalidated.

## Validate data transformations

For important transformations, validate whichever contracts apply:

- expected columns/fields and types;
- units and encodings;
- identifier/key uniqueness;
- duplicates and missingness;
- valid ranges and categorical levels;
- row counts before and after filters;
- join cardinality and unmatched keys;
- ordering and grouping assumptions;
- output shape and identifiers.

Treat unexpected many-to-many joins, silent coercions, severe row loss, and unexpected record multiplication as likely bugs until explained.

## Language-specific work

Use the `data-analysis` skill for language-specific guidance. Follow the repository's existing dependency, formatting, linting, typing, testing, and packaging choices; do not introduce a second toolchain without a concrete need.

## LSP and diagnostics

Use LSP navigation/diagnostics when the installed OpenCode runtime and project language server support it. Do not depend on LSP being available.

- Prefer targeted symbol lookup over reading many large files when LSP can answer the question.
- Treat project lint, type-check, compiler, and test commands as authoritative verification.
- If LSP disagrees with project tooling, investigate the discrepancy rather than silently choosing one.

## Git

- Inspect repository status before broad modifications.
- Do not discard unrelated user changes.
- Do not rewrite history, commit, push, tag, or create branches unless requested or required by an established workflow.
- Never commit secrets or credentials.
- Keep code/version-control concerns separate from external dataset provenance where DataLad manages data inputs.

## Documentation

Update Markdown documentation when changes alter execution, inputs, outputs, parameters, environment, important assumptions, interpretation, or provenance procedures.

Prefer concise documentation with executable commands over unverifiable prose.

## Verification

After modifying code:

1. run the narrowest relevant check;
2. run existing formatting/lint/type checks where applicable;
3. run focused tests;
4. validate relevant data invariants;
5. use a small representative input before a full analysis run.

Never claim a command or test succeeded unless it actually ran successfully. If verification is blocked by missing data, container images, language servers, external resources, or compute, state exactly what was and was not verified.

## External directories

Repositories, DataLad datasets, container sources, and resources outside the current worktree are separate resources. Read them when necessary and authorized, but do not modify them as a side effect of current-project work.

## What `/init` should add for this project

A project `AGENTS.md` should capture concrete facts that can be established from the repository, including as applicable:

- project purpose and outputs;
- languages actually used;
- important directories and pipeline entry points;
- test, lint, format, type-check, and validation commands;
- expected Apptainer image and invocation;
- external dataset locations/acquisition mechanisms and DataLad conventions;
- output/intermediate locations;
- expensive or unsafe operations to avoid;
- project-specific statistical/scientific assumptions;
- documentation conventions and known operational gotchas.

Do not add instructions for languages or tools that the repository does not use.
