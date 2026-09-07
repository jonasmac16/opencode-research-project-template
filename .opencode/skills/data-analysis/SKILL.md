---
name: data-analysis
description: Implement, modify, debug, or understand data-analysis and data-processing code in Python, R, Julia, Markdown/notebooks, or mixed-language repositories. Use for analysis logic, pipeline changes, code navigation, language-specific execution/testing, or repository intake. Load only the language/tool references relevant to the current project and task.
---

# Data analysis workflow

1. Inspect repository evidence before choosing a language/tool workflow.
2. Identify the relevant input -> transformation -> output path and the narrowest executable entry point.
3. Load only the reference files needed for the current task:
   - Python: `references/python.md`
   - R: `references/r.md`
   - Julia: `references/julia.md`
   - Markdown/notebooks/Quarto/R Markdown: `references/markdown-notebooks.md`
   - LSP navigation/diagnostics: `references/lsp.md`
4. Follow the project's existing dependency, formatting, testing, and execution conventions.
5. Keep reusable analysis logic in testable functions/modules when consistent with repository structure.
6. Prefer focused/small-input execution before expensive full-data work.
7. Use `data-validation` for transformations whose correctness depends on schema, identifiers, filtering, joins, grouping, or output contracts.
8. Use `reproducibility` when external DataLad inputs, Apptainer environments, provenance, or exact rerunability matter.

Do not load guidance for languages or tools absent from the current task.
