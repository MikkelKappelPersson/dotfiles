#!/usr/bin/env bash
# chezmoi run_once: make Betterbird adopt the profile that chezmoi manages.
#
# The managed prefs live in ~/.thunderbird/p4dv0owj.default-default. On a new
# machine that directory exists after `chezmoi apply` but Betterbird would
# otherwise create a randomly named profile of its own and ignore it. Pin it in
# profiles.ini instead. profiles.ini is deliberately NOT managed by chezmoi:
# Thunderbird and Betterbird share ~/.thunderbird, and both rewrite profiles.ini
# and installs.ini at startup (installs.ini keys are per install path), so
# appending an entry here keeps both clients working and keeps chezmoi out of
# the way.
#
# Run this before Betterbird's first launch. Idempotent: re-running is a no-op.

set -euo pipefail

profile='p4dv0owj.default-default'
tb_dir="${HOME}/.thunderbird"
profile_dir="${tb_dir}/${profile}"

# The profile directory itself, in case chezmoi had nothing to write there.
install -d -m 700 "${profile_dir}"

if [ -f "${tb_dir}/profiles.ini" ] && grep -q "^Path=${profile}$" "${tb_dir}/profiles.ini"; then
    echo "thunderbird: profile ${profile} already registered"
    exit 0
fi

# Only claim Default=1 when no profile has it, so an existing Thunderbird
# default profile is not stolen.
if [ -f "${tb_dir}/profiles.ini" ] && grep -q '^Default=1$' "${tb_dir}/profiles.ini"; then
    claim_default=''
else
    claim_default='Default=1'
fi

{
    echo ''
    echo '[Profile-chezmoi]'
    echo "Name=${profile}"
    echo 'IsRelative=1'
    echo "Path=${profile}"
    [ -n "${claim_default}" ] && echo "${claim_default}"
    true
} >>"${tb_dir}/profiles.ini"

echo "thunderbird: registered profile ${profile} in profiles.ini"
if [ -z "${claim_default}" ]; then
    echo "thunderbird: another profile is the default; check that Betterbird picks ${profile}"
fi
