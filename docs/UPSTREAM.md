# Upstream references and maintenance notes

Checked: 2026-09-07.

- Project config and precedence: https://opencode.ai/docs/config/
- Instructions and `AGENTS.md`: https://opencode.ai/docs/rules/
- Project skills: https://opencode.ai/docs/skills/
- Project commands: https://opencode.ai/docs/commands/
- Project agents: https://opencode.ai/docs/agents/
- Project plugins: https://opencode.ai/docs/plugins/
- V1/current LSP tool and servers: https://opencode.ai/docs/tools/ and https://opencode.ai/docs/lsp/
- V2 compaction: https://opencode.ai/v2/docs/compaction
- V2 LSP status: https://opencode.ai/v2/docs/lsp
- R languageserver: https://github.com/REditorSupport/languageserver

When upgrading OpenCode, re-check especially:

1. compaction field names;
2. V2 LSP runtime status;
3. command child/subtask fields;
4. skill discovery/frontmatter behavior;
5. plugin hook naming/stability.
