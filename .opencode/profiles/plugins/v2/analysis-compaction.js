import { Plugin } from "@opencode-ai/plugin"

const continuationContext = `
## Data-analysis continuation requirements

When these facts are known and still relevant, preserve them in the compaction checkpoint. Do not invent missing values.

### Objective and scientific state
- Current analysis question/objective and status.
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
- Whether commands ran in the intended container or on the host.

### Code and output state
- Files intentionally modified and important entry points/functions involved.
- Intermediate/final outputs produced, invalidated, stale, or pending.
- Decisions not obvious from committed code or AGENTS.md.

### Verification
- Exact checks/tests/linters/type checks/data validations run and outcomes.
- Checks still outstanding or blocked, including why.
- Known blockers, unresolved anomalies, and next concrete actions.

Prefer compact factual bullets. Do not preserve conversational filler, repeated tool output, or facts already obvious from durable project files unless needed to resume correctly.
`

export default Plugin.define({
  id: "analysis-compaction",
  async setup(ctx) {
    const registration = await ctx.session.hook("context", (event) => {
      if (event.kind !== "compaction") return
      event.system.push({ text: continuationContext })
    })

    return () => registration.dispose()
  },
})
