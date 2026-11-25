#!/usr/bin/env bash
# Clone + update omh in ~/projects/omh.
# The repo is a git checkout, NOT chezmoi-managed files (same pattern as
# run_pi-extensions-clone.sh). Runs on every `chezmoi apply`:
# clones when missing, `git pull --ff-only` when present, then
# (re)creates the ~/.local/bin/omh* symlinks the Alt+X hotkey calls.
# Idempotent: never fails apply on pull errors.
set -euo pipefail

REPO_URL="https://github.com/MikkelKappelPersson/omh.git"
DEST="${HOME}/projects/omh"

mkdir -p "$(dirname "${DEST}")"

if [ -d "${DEST}/.git" ]; then
  echo "omh: pulling latest"
  git -C "${DEST}" pull --ff-only || echo "omh: pull failed, keeping local state" >&2
else
  if [ -e "${DEST}" ]; then
    echo "omh: ${DEST} exists but is not a git repo, skipping" >&2
  else
    echo "omh: cloning ${REPO_URL}"
    git clone "${REPO_URL}" "${DEST}"
  fi
fi

mkdir -p "${HOME}/.local/bin"
for tool in omh omh-send-last; do
  link="${HOME}/.local/bin/${tool}"
  target="${DEST}/bin/${tool}"
  if [ -L "${link}" ] && [ "$(readlink "${link}")" = "${target}" ]; then
    echo "omh: symlink ${tool} already correct"
  else
    ln -sfn "${target}" "${link}"
    echo "omh: linked ${link} -> ${target}"
  fi
done

echo "omh ready"
