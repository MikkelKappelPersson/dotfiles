---
name: herdr
description: "Herdr tooling: hc (herdr-core) runs agents and programs in persistent terminals, herdr-app drives the desktop window, herdr is the older TUI multiplexer. Use when the user mentions Herdr, hc, herdr-core or herdr-app. Do not use merely because a task could benefit from background work."
---

# Herdr

Herdr is three CLIs. Pick by job, then run its `--skill` — the binary's own output is the authoritative manual:

- `hc --skill` — herdr-core: run programs/agents in persistent terminals, delegate, wait, read, remote machines/files. **Default for orchestration.**
- `herdr-app --skill` — desktop window: spaces, tabs, panes, focus, splits, shots. Only for visible layout changes.
- `herdr --skill` — older TUI multiplexer, only for that specific instance. Requires `HERDR_ENV=1`; if unset, say you're not inside Herdr and stop.

Use `<tool> <command> --help` for exact args. Never run bare `herdr` or `herdr-app` for discovery — they launch the TUI / open the window.
