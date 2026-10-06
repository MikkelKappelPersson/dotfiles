#!/usr/bin/env bash
# Clone + update pi extensions in ~/.pi/agent/extensions/.
# These are git repos, NOT chezmoi-managed files and NOT npm packages.
# Runs on every `chezmoi apply` (which `chezmoi update` triggers):
# clones missing repos, then `git pull --ff-only` all existing git checkouts.
# Idempotent: skips non-git dirs, never fails apply on pull errors.
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
clone_if_missing "pi-opencode-direct-rotator" "https://github.com/MikkelKappelPersson/pi-opencode-direct-rotator.git"
clone_if_missing "pi-ops" "https://github.com/MikkelKappelPersson/pi-ops.git"

# Pull all git-repo extensions (covers future additions, not just the list above).
for dest in "${EXT_DIR}"/*/; do
  [ -d "${dest}.git" ] || continue
  name="$(basename "${dest}")"
  echo "pi extension ${name}: pulling latest"
  git -C "${dest}" pull --ff-only || echo "pi extension ${name}: pull failed, keeping local state" >&2
done

ensure_deps "pi-shepherd"
ensure_deps "pi-zvec-grep"
ensure_deps "pi-opencode-direct-rotator"
ensure_deps "pi-ops"

# pi-opencode-direct-rotator needs a physical pi-ai copy at runtime (Pi's
# loader doesn't map the .lazy subpaths), but it must NOT be in
# dependencies (host-provided packages must be peer-only, else Pi warns).
# --no-save installs the files without touching package.json.
if [ -d "${EXT_DIR}/pi-opencode-direct-rotator" ] && [ ! -d "${EXT_DIR}/pi-opencode-direct-rotator/node_modules/@earendil-works/pi-ai" ]; then
  echo "pi extension pi-opencode-direct-rotator: installing runtime pi-ai copy (no-save)"
  (cd "${EXT_DIR}/pi-opencode-direct-rotator" && npm install --no-save @earendil-works/pi-ai@0.86.1)
fi

echo "pi extensions ready"
