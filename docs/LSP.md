# Project-local LSP integration

LSP configuration is stored in this repository's project config; no global LSP setting or shell profile is changed.

## OpenCode V1/current

The LSP tool is experimental and requires `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` (or the broader experimental flag). Launching with:

```sh
./.opencode/bin/opencode-data
```

sets that variable only for the `opencode` process started by the script.

The unspecialized project config declares an R server:

```text
R --no-echo -e languageserver::run()
```

The R `languageserver` package must already be installed in the R environment that launches OpenCode. Python/Julia server availability depends on the OpenCode/runtime installation and project tooling.

`/init-analysis` should remove project-local language-specific LSP configuration when that language is confirmed unused. `.opencode/bin/check-environment.sh` determines which Python/R/Julia checks to run from the retained language reference files.

## OpenCode V2 beta

As of 2026-09-08, V2 accepts and preserves `lsp` configuration but does not start/download language servers, expose an LSP tool, or return LSP diagnostics. Select the V2 local profile with:

```sh
./.opencode/bin/select-profile.sh v2
```

Then run `opencode2` and rely on project lint/type/test/compiler commands for verification.

## Container caveat

If analysis executes inside Apptainer while a language server runs on the host, dependency versions and filesystem paths may differ. Use LSP for navigation/advisory diagnostics; treat checks executed in the documented project/container environment as authoritative.
