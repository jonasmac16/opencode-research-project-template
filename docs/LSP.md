# Project-local LSP integration

LSP configuration is stored in this repository's `opencode.json`; no global LSP setting or shell profile is changed.

## OpenCode V1/current

The `lsp` tool is experimental and requires `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` (or the broader experimental flag). Launching with:

```sh
./.opencode/bin/opencode-data
```

sets that variable only for the `opencode` process started by the script.

The project config uses object-form LSP configuration and declares an R server:

```text
R --no-echo -e languageserver::run()
```

The R `languageserver` package must already be installed in the R environment that launches OpenCode. Python/Julia server availability depends on the OpenCode/runtime installation and project tooling.

## OpenCode V2 beta

As of 2026-09-07, V2 accepts and preserves `lsp` configuration but does not start/download language servers, expose an LSP tool, or return LSP diagnostics. Select the V2 local profile with:

```sh
./.opencode/bin/select-profile.sh v2
```

Then run `opencode2` normally and rely on project lint/type/test/compiler commands for verification.

## Container caveat

If the analysis executes inside Apptainer while a language server runs on the host, dependency versions and filesystem paths may differ. Use LSP for navigation/advisory diagnostics; treat checks executed in the documented project/container environment as authoritative.
