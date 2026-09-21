#!/usr/bin/env bash
# Clone locally-developed pi extensions into ~/.pi/agent/extensions/.
# These are git repos, NOT chezmoi-managed files and NOT npm packages,
# so a fresh machine needs them cloned once. Idempotent: skips existing checkouts.
set -euo pipefail

EXT_DIR="${HOME}/.pi/agent/extensions"
mkdir -p "${EXT_DIR}"

clone_if_missing() {
  local name="$1" url="$2"
  local dest="${EXT_DIR}/${name}"
  if [ -d "${dest}/.git" ]; then
    echo "pi extension ${name}: already present, skipping"
    return 0
  fi
  if [ -e "${dest}" ]; then
    echo "pi extension ${name}: ${dest} exists but is not a git repo, skipping" >&2
    return 0
  fi
  echo "pi extension ${name}: cloning ${url}"
  git clone "${url}" "${dest}"
}

ensure_deps() {
  local name="$1"
  local dest="${EXT_DIR}/${name}"
  if [ -f "${dest}/package.json" ] && [ ! -d "${dest}/node_modules" ]; then
    echo "pi extension ${name}: installing dependencies"
    (cd "${dest}" && npm install --omit=dev)
  fi
}

clone_if_missing "pi-shepherd" "https://github.com/MikkelKappelPersson/pi-shepherd.git"
clone_if_missing "pi-zvec-grep" "https://github.com/MikkelKappelPersson/pi-zvec-grep.git"

ensure_deps "pi-shepherd"
ensure_deps "pi-zvec-grep"

echo "pi extensions ready"
