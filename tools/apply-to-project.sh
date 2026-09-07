#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
TARGET=${1:-}
FORCE=0

if [ -z "$TARGET" ]; then
  printf 'Usage: %s /path/to/project [--force]\n' "$0" >&2
  exit 2
fi
shift
if [ "${1:-}" = "--force" ]; then
  FORCE=1
  shift
fi
if [ "$#" -ne 0 ]; then
  printf 'Usage: %s /path/to/project [--force]\n' "$0" >&2
  exit 2
fi
if [ ! -d "$TARGET" ]; then
  printf 'Target directory does not exist: %s\n' "$TARGET" >&2
  exit 1
fi

copy_item() {
  item_src=$1
  item_dst=$2
  if [ -e "$item_dst" ]; then
    if [ "$FORCE" -ne 1 ]; then
      printf 'KEEP %s (use --force to replace)\n' "$item_dst"
      return
    fi
    item_backup="${item_dst}.bak.$(date +%Y%m%d%H%M%S)"
    mv "$item_dst" "$item_backup"
    printf 'BACKUP %s -> %s\n' "$item_dst" "$item_backup"
  fi
  mkdir -p "$(dirname -- "$item_dst")"
  cp -R "$item_src" "$item_dst"
  printf 'ADD  %s\n' "$item_dst"
}

copy_item "$ROOT/AGENTS.md" "$TARGET/AGENTS.md"
copy_item "$ROOT/opencode.json" "$TARGET/opencode.json"
copy_item "$ROOT/.opencode/.gitignore" "$TARGET/.opencode/.gitignore"

for group in agents commands plugins skills profiles bin; do
  for child in "$ROOT/.opencode/$group"/*; do
    [ -e "$child" ] || continue
    copy_item "$child" "$TARGET/.opencode/$group/$(basename -- "$child")"
  done
done

copy_item "$ROOT/docs/DECISIONS.md" "$TARGET/docs/DECISIONS.md"
copy_item "$ROOT/docs/CONFIG-PROFILES.md" "$TARGET/docs/CONFIG-PROFILES.md"
copy_item "$ROOT/docs/LSP.md" "$TARGET/docs/LSP.md"

chmod +x "$TARGET/.opencode/bin/opencode-data" \
  "$TARGET/.opencode/bin/check-environment.sh" \
  "$TARGET/.opencode/bin/select-profile.sh"

printf '\nApplied only project-local OpenCode files. No files under ~/.config/opencode were modified.\n'
printf 'Next: cd %s && ./.opencode/bin/check-environment.sh && ./.opencode/bin/opencode-data, then run /init.\n' "$TARGET"
