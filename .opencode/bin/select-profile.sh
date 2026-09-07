#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
PROFILE=${1:-}

case "$PROFILE" in
  v1|v2) ;;
  *)
    printf 'Usage: %s v1|v2\n' "$0" >&2
    printf '  v1 = stable/current opencode; experimental LSP tool available\n' >&2
    printf '  v2 = opencode2 beta; V2 compaction plugin/config, no LSP runtime yet\n' >&2
    exit 2
    ;;
esac

CONFIG_SRC="$ROOT/.opencode/profiles/opencode.$PROFILE.json"
PLUGIN_SRC="$ROOT/.opencode/profiles/plugins/$PROFILE/analysis-compaction.js"
PLUGIN_DST="$ROOT/.opencode/plugins/analysis-compaction.js"
BACKUP_DIR="$ROOT/.opencode/backups"
STAMP=$(date +%Y%m%d%H%M%S)
mkdir -p "$BACKUP_DIR"

if [ -e "$ROOT/opencode.json" ]; then
  cp "$ROOT/opencode.json" "$BACKUP_DIR/opencode.json.$STAMP"
  printf 'BACKUP %s\n' "$BACKUP_DIR/opencode.json.$STAMP"
fi
if [ -e "$PLUGIN_DST" ]; then
  cp "$PLUGIN_DST" "$BACKUP_DIR/analysis-compaction.js.$STAMP"
  printf 'BACKUP %s\n' "$BACKUP_DIR/analysis-compaction.js.$STAMP"
fi

cp "$CONFIG_SRC" "$ROOT/opencode.json"
cp "$PLUGIN_SRC" "$PLUGIN_DST"
printf 'Selected project-local OpenCode profile: %s\n' "$PROFILE"
