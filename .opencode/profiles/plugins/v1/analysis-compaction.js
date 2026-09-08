/**
 * Preserve analysis-specific state when OpenCode compacts a long session.
 * No external npm dependencies are required.
 */
export const AnalysisCompactionPlugin = async () => {
  return {
    "experimental.session.compacting": async (_input, output) => {
      output.context.push(`
## Data-analysis continuation requirements

When these facts are known and still relevant, preserve them in the checkpoint. Do not invent missing values.

### Objective and scientific state
- Current analysis question/objective and current status.
- Project-specific scientific/language constraints from `.opencode/project-profile.md` when they are relevant to resuming correctly; do not invent or reinterpret them.
- Important scientific/statistical assumptions and decisions.
- Filtering, exclusion, grouping, weighting, unit, and join-cardinality decisions.
- Random seeds and important parameters that affect results.

### Input provenance
- External DataLad dataset paths or documented sources.
- Exact dataset revisions/commits used.
- Specific input files/subsets obtained or consumed.
- Whether required annexed content is locally available.

### Execution environment
- Apptainer image/path/reference and digest/version if known.
- Relevant bind mounts, environment variables, working directory, and invocation command.
- Whether commands were run in the intended container or on the host.

### Code and output state
- Files intentionally modified and important entry points/functions involved.
- Intermediate/final outputs produced, invalidated, stale, or still pending.
- Decisions that are not obvious from committed code or project AGENTS.md or `.opencode/project-profile.md`.

### Verification
- Exact checks/tests/linters/type checks/data validations already run and their outcomes.
- Checks that remain outstanding or could not run, including why.
- Known blockers, unresolved anomalies, and next concrete actions.

Prefer compact factual bullets. Do not preserve conversational filler, repeated tool output, or facts already obvious from durable project files unless needed to resume correctly.
`)
    }
  }
}
