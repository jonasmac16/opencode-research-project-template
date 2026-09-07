---
description: Inspect a dataset or data-processing boundary in an isolated child session without modifying source data
agent: plan
subagent: true
subtask: true
---

Inspect $ARGUMENTS as a data-analysis input, intermediate, or output.

Use the `data-validation` skill and, for external DataLad inputs, the `reproducibility` skill. Establish only what can be checked safely and cheaply: shape/schema, identifiers, duplicates, missingness, ranges/levels, units/encodings when documented, and relevant join/grouping assumptions.

Do not retrieve an entire external dataset, mutate source data, write derived outputs, or run an expensive full analysis merely to inspect it. Return concise findings and any checks that remain necessary.
