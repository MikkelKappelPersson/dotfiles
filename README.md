# dotfiles

Managed with [chezmoi](https://www.chezmoi.io/). Source state is `home/` (see `.chezmoiroot`).

## Layout

| Path | Purpose |
|---|---|
| `home/` | chezmoi source state |
| `home/.chezmoidata/packages.yaml` | package lists used by install scripts |
| `home/private_dot_pi/` | pi config: `settings.json.tmpl`, `models.json`, `AGENTS.md` |
| `home/run_pi-extensions-clone.sh` | clone/pull pi extension git repos (runs every apply) |
| `home/run_onchange_endeavouros-install-packages.sh.tmpl` | package install on package-list change |
| `home/run_onchange_gnome-*.sh.tmpl` | GNOME settings/shortcuts on change |
| `.github/copilot-instructions.md` | machine spec for agents working in this repo |

Not tracked on purpose: the Betterbird/Thunderbird profile (`~/.thunderbird`).
Mail account, identity, server and calendar definitions live only on the machine
that uses them; credentials (`key4.db`, `logins.json`) must never be committed.

## Scripts

Prefixes follow chezmoi semantics:

- `run_` — every `apply` / `update`
- `run_onchange_` — only when the script's own content changed
- `run_once_` — once per unique content hash

`chezmoi status` lists every `run_` script as ` R <name>`. That means "apply will run this",
not "this drifted". Only a non-space character in the first column (`M`, `A`, `D`) is drift.

### `run_pi-extensions-clone.sh`

Kept as `run_` on purpose: it must clone missing pi extension repos and
`git pull --ff-only` existing ones on every apply, which is what `run_` means.
`run_onchange_` keys off the script's own content, so the pulls would stop.

It is idempotent and non-fatal: existing non-git directories are skipped, pull errors are
logged and ignored, and unmanaged files inside the clones (`node_modules/`, local edits)
are left alone. `npm install` steps live here because chezmoi's native `git-repo`
externals cannot install packages.

## Usage

```sh
chezmoi update          # git pull + apply
chezmoi apply           # apply only
chezmoi diff            # preview
chezmoi status          # see what would change
```

After editing `home/private_dot_pi/private_agent/settings.json.tmpl`, run
`chezmoi apply ~/.pi/agent/settings.json` and `/reload` in pi.
