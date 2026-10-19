# Agent notes

Dotfiles managed with chezmoi. Source state is `home/` (`.chezmoiroot` = `home`),
so files at this repo root are **not** deployed anywhere — they only document the repo.

## `chezmoi status` / `chezmoi diff`

`chezmoi status` prints ` R <name>` for every `run_` script on every invocation.
`R` means "apply will execute this script". It is not drift, there is nothing to fix,
and it should not be reported as a remaining delta or offered as a question.

Real drift is a non-space character in the **first** column (`M`, `A`, `D`).
Second-column entries are predictions of what `apply` will do.

`chezmoi diff` likewise prints the entire body of every `run_` script as a "new file"
hunk. That is the script content `apply` would execute, not a file diff.

## `home/run_pi-extensions-clone.sh`

Intentionally `run_`, not `run_once_` or `run_onchange_`:

- `run_once_` = content hash never seen before → runs ~once per machine.
- `run_onchange_` = the **script's own content** changed → effectively never here.
- `run_` = every apply/update → required, because it clones missing pi extension
  repos and `git pull --ff-only`s existing ones on each apply.

Renaming it to `run_onchange_` would silently stop the pulls. Leave the prefix alone
unless the user explicitly asks to change the pull behavior.

Deliberate properties worth preserving:

- Pull failures are non-fatal (`|| echo ...`), so a dirty checkout never breaks `apply`.
- Unmanaged files inside the clones (`node_modules/`, local edits) are untouched.
- `npm install` and the `--no-save @earendil-works/pi-ai` step live here because
  chezmoi's native `git-repo` externals cannot run package installs.

Native `.chezmoiexternal.toml` `git-repo` entries were evaluated and rejected: they
abort `apply` on a dirty checkout and cannot handle dependency installs.

## Pi config

- `home/private_dot_pi/private_agent/settings.json.tmpl` generates
  `~/.pi/agent/settings.json`. Edit the template, not the deployed file.
- `lastChangelogVersion` is read from the deployed file on purpose, so `chezmoi status`
  stays clean across pi upgrades.
- After editing the template: `chezmoi apply ~/.pi/agent/settings.json`, then `/reload` in pi.
