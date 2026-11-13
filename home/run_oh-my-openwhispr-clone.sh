#!/usr/bin/env bash
# Clone + update oh-my-openwhispr in ~/Projects/oh-my-openwhispr.
# The repo is a git checkout, NOT chezmoi-managed files (same pattern as
# run_pi-extensions-clone.sh). Runs on every `chezmoi apply`:
# clones when missing, `git pull --ff-only` when present, then
# (re)creates the ~/.local/bin/omo* symlinks the Alt+X hotkey calls.
# Idempotent: never fails apply on pull errors.
set -euo pipefail

REPO_URL="https://github.com/MikkelKappelPersson/oh-my-openwhispr.git"
DEST="${HOME}/Projects/oh-my-openwhispr"

mkdir -p "$(dirname "${DEST}")"

if [ -d "${DEST}/.git" ]; then
  echo "oh-my-openwhispr: pulling latest"
  git -C "${DEST}" pull --ff-only || echo "oh-my-openwhispr: pull failed, keeping local state" >&2
else
  if [ -e "${DEST}" ]; then
    echo "oh-my-openwhispr: ${DEST} exists but is not a git repo, skipping" >&2
  else
    echo "oh-my-openwhispr: cloning ${REPO_URL}"
    git clone "${REPO_URL}" "${DEST}"
  fi
fi

mkdir -p "${HOME}/.local/bin"
for tool in omo omo-send-last; do
  link="${HOME}/.local/bin/${tool}"
  target="${DEST}/bin/${tool}"
  if [ -L "${link}" ] && [ "$(readlink "${link}")" = "${target}" ]; then
    echo "oh-my-openwhispr: symlink ${tool} already correct"
  else
    ln -sfn "${target}" "${link}"
    echo "oh-my-openwhispr: linked ${link} -> ${target}"
  fi
done

echo "oh-my-openwhispr ready"
