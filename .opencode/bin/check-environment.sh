#!/bin/sh
set -u

ok=0
warn=0
check_cmd() {
  label=$1
  cmd=$2
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'OK   %-24s %s\n' "$label" "$(command -v "$cmd")"
  else
    printf 'WARN %-24s not found\n' "$label"
    warn=$((warn + 1))
  fi
}

check_cmd "OpenCode V1" opencode
check_cmd "OpenCode V2 beta" opencode2
check_cmd "Git" git
check_cmd "DataLad" datalad
check_cmd "Apptainer" apptainer
check_cmd "Python" python3
check_cmd "Pyright" pyright
check_cmd "R" R
check_cmd "Julia" julia

if command -v R >/dev/null 2>&1; then
  if R --slave -e 'quit(status=ifelse(requireNamespace("languageserver", quietly=TRUE), 0, 1))' >/dev/null 2>&1; then
    printf 'OK   %-24s installed\n' "R languageserver"
  else
    printf 'WARN %-24s not installed in this R library\n' "R languageserver"
    warn=$((warn + 1))
  fi
fi

if command -v julia >/dev/null 2>&1; then
  if julia -e 'using LanguageServer' >/dev/null 2>&1; then
    printf 'OK   %-24s available\n' "Julia LanguageServer.jl"
  else
    printf 'WARN %-24s not available in the active Julia environment\n' "Julia LanguageServer.jl"
    warn=$((warn + 1))
  fi
fi

printf '\nOPENCODE_EXPERIMENTAL_LSP_TOOL=%s\n' "${OPENCODE_EXPERIMENTAL_LSP_TOOL:-<unset>}"
printf 'Warnings: %s\n' "$warn"
exit "$ok"
