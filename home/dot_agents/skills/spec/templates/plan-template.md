# Plan — [FEATURE NAME]

`spec/[NNN-slug]` · draft · [DATE] · spec: `spec.md`

<!--
  Technical design only. NO tasks, phases, checkboxes, or "step 1".
  Derived from spec.md; work items belong in tasks.md.
-->

## Summary

[Primary requirements from spec.md + chosen technical approach in 2–3 sentences.]

## Requirement coverage

- **FR-001** → [component / interface that satisfies it]
- **FR-002** → [component / interface that satisfies it]

## Technical context

- **Language / runtime**: [e.g. Python 3.10+ stdlib, Rust 1.80]
- **Dependencies**: [libraries, or "none"; mark NEEDS CLARIFICATION]
- **Storage**: [files / DB / none, with paths]
- **Platform**: [OS, desktop, device]
- **Constraints**: [latency, memory, offline, permissions]

## Architecture

[Components and how they talk. Small diagram or tree if useful.]

```text
[component] -> [component] -> [storage]
```

## Data model

[Entities, fields, formats, ownership, file layout.]

- `[entity]`: [meaning]; fields `a, b, c`.
- Paths: `[path]` — [writer], [reader].

## Interfaces

[CLI commands, APIs, UI surfaces, env vars. Contracts, not implementations.]

| interface | behavior |
|---|---|
| `[cmd/flag]` | [what it does] |

Env: `[VAR]` — [meaning, default].

## Invariants

- [Must always hold, e.g. "no data loss on failed delivery".]
- [Must never happen, e.g. "never write another app's database".]

## Failure behavior

- [Failure] ⇒ [state, recovery path, user-visible signal].
- [Timeout] ⇒ [state, guard against blind retry].

## Recovery

- [Crash / stale state / orphan process handling.]

## Open questions

1. [Unresolved decision + what evidence would settle it.]
