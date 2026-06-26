#!/bin/bash

DEFAULT_EDITOR="vscodium"
WORKSPACE_EDITOR="${VSC_WORKSPACES_EDITOR:-$DEFAULT_EDITOR}"
ROFI_PROMPT="${VSC_WORKSPACES_PROMPT:-${WORKSPACE_EDITOR##*/}}"

declare -a LABELS PATHS

while IFS=$'\t' read -r label path; do
    LABELS+=("$label")
    PATHS+=("$path")
done < <(python3 - << 'EOF'
import os, json
from pathlib import Path
from urllib.parse import unquote

config_dir = Path.home() / '.config'
bases = [
    config_dir / 'Code/User/workspaceStorage',
    config_dir / 'Code - OSS/User/workspaceStorage',
    config_dir / 'VSCodium/User/workspaceStorage',
]
home = str(Path.home())
entries = []

for base in bases:
    if not base.is_dir():
        continue
    for d in base.iterdir():
        ws_json = d / 'workspace.json'
        db = d / 'state.vscdb'
        if not ws_json.exists():
            continue
        try:
            data = json.loads(ws_json.read_text())
            uri = data.get('folder') or data.get('configuration')
            if not uri or not uri.startswith('file://'):
                continue
            path = unquote(uri[7:])
            if not os.path.exists(path):
                continue
            mtime = db.stat().st_mtime if db.exists() else ws_json.stat().st_mtime
            entries.append((mtime, path))
        except Exception:
            pass

entries.sort(reverse=True)
seen = set()
for mtime, path in entries:
    if path in seen:
        continue
    seen.add(path)
    name = os.path.basename(path.rstrip('/'))
    display = path.replace(home, '~', 1)
    print(f'{name}  {display}\t{path}')
EOF
)

[[ ${#LABELS[@]} -eq 0 ]] && exit 1

CHOSEN=$(printf '%s\n' "${LABELS[@]}" | rofi -dmenu -i -matching fuzzy -p "$ROFI_PROMPT")
[[ -z "$CHOSEN" ]] && exit 0

for i in "${!LABELS[@]}"; do
    [[ "${LABELS[$i]}" == "$CHOSEN" ]] && exec "$WORKSPACE_EDITOR" "${PATHS[$i]}"
done
