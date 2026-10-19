# Pi user instructions

## Chezmoi / dotfiles

Dotfiles repo: `github.com/MikkelKappelPersson/dotfiles`
Source dir: `~/.local/share/chezmoi`, with `.chezmoiroot` = `home`.
Files outside `home/` (e.g. `README.md`, `.github/`) are not part of the source state.

### `chezmoi status` output

`chezmoi status` prints ` R <name>` for every `run_` script on every invocation.
`R` means "apply will execute this script" — it is not drift and there is nothing to fix.
Do **not** report it as a remaining delta, and do not ask whether to change it.

Real drift is a non-space character in the **first** column (`M`, `A`, `D`).
Second-column entries are predictions of what `apply` will do.

### `home/run_pi-extensions-clone.sh`

Intentionally `run_`, not `run_once_` or `run_onchange_`:

- `run_once_` = content hash never seen before → runs ~once per machine.
- `run_onchange_` = the **script's own content** changed → effectively never for this script.
- `run_` = every apply/update → required, because the script clones missing pi extension
  repos and `git pull --ff-only`s existing ones on each apply.

Renaming it to `run_onchange_` would silently stop the pulls. Leave the prefix alone
unless the user explicitly asks to change the pull behavior.

Deliberate properties worth preserving:

- Pull failures are non-fatal (`|| echo ...`), so a dirty checkout never breaks `apply`.
- Unmanaged files inside the clones (`node_modules/`, local hacks) are untouched.
- `npm install` / the `--no-save @earendil-works/pi-ai` step live here because chezmoi's
  native `git-repo` externals cannot run package installs.

Native `.chezmoiexternal.toml` `git-repo` entries were evaluated and rejected: they abort
`apply` on a dirty checkout and cannot handle dependency installs.

## Pi config

- `~/.pi/agent/settings.json` is generated from
  `home/private_dot_pi/private_agent/settings.json.tmpl`. Edit the template, not the target.
- `lastChangelogVersion` is preserved from the live file on purpose, so `chezmoi status`
  stays clean across pi upgrades.
- `defaultTools: ["+codemode"]` keeps the default tools and adds `codemode`.
