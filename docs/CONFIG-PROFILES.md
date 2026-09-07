# Project-local OpenCode configuration profiles

All profile operations are project-local. None modifies `~/.config/opencode/`.

The inactive profile sources live under `.opencode/profiles/` so OpenCode-specific infrastructure stays out of the project root. Only `opencode.json` and `.opencode/plugins/analysis-compaction.js` are active at runtime.

## V1/current profile (checked-in default)

`.opencode/profiles/opencode.v1.json` enables:

- automatic compaction;
- old-tool-output pruning;
- a 20k reserved buffer;
- project skill/external-directory/LSP permissions;
- custom R language-server declaration.

`.opencode/profiles/plugins/v1/analysis-compaction.js` uses the V1 `experimental.session.compacting` plugin hook.

Select/reset V1 for this repository with:

```sh
./.opencode/bin/select-profile.sh v1
```

## V2 beta profile

`.opencode/profiles/opencode.v2.json` enables checkpoint compaction with a 12k recent-context tail and 20k buffer. V2 accepts the LSP declaration but currently has no LSP runtime.

`.opencode/profiles/plugins/v2/analysis-compaction.js` uses the V2 plugin API and adds analysis continuation requirements only to `event.kind === "compaction"` model context.

Select V2 for this repository with:

```sh
./.opencode/bin/select-profile.sh v2
```

## What the selector changes

The selector changes only:

```text
./opencode.json
./.opencode/plugins/analysis-compaction.js
```

It first copies the previous local files into ignored `.opencode/backups/`. The profile source files themselves are not auto-discovered by OpenCode.
