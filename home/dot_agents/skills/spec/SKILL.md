---
name: spec
description: >
  Spec-first development. Use when starting a feature or project, capturing
  intent, writing a specification, planning implementation, or breaking work
  into tasks. Use when the user mentions intent/spec/plan/research/tasks or a
  numbered spec folder. Produces spec/NNN-slug/ with an intent.md (what was
  asked for, in the originator's own words), a spec.md (what was decided, as
  testable requirements), a technical plan with no tasks, optional research,
  and a phased task checklist.
---

# Spec

Specs live in `spec/`, one numbered folder per effort:

```
spec/
  001-omo-app/
    intent.md      # what was asked for — proto-spec, originator's words (always)
    spec.md        # what was decided — feature spec, testable requirements (always)
    plan.md        # how: technical design (always, no tasks)
    research.md    # findings / spikes        (only when needed)
    tasks.md       # what to do, phased checklist (always)
```

Folder: `NNN-slug` — zero-padded sequence, short kebab slug (`001-omo-app`).
Keep every file small; link instead of repeating.

## Two artifacts, two jobs

- **`intent.md`** comes from the Claude Academy *capture as intent* play. It is a
  proto-spec written by the originator — often a non-technical person — in their
  own words. Plain language is fine. It records the **ask**: the problem, the
  desired outcome, who is affected, the constraints, and open questions. It
  carries author + timestamp + revision history, and the product owner reviews
  and approves it before any design work.
- **`spec.md`** comes from GitHub spec-kit's Feature Specification. It is
  derived from the approved intent and records the **decision**: testable user
  scenarios, functional requirements, success criteria, and assumptions. It is
  written for business stakeholders and is the contract engineering plans
  against. No implementation detail.
- Keep the two together: the pair records *what was asked for* and *what was
  decided*. Commit them to the same folder.

## Sources

- Claude Academy — [Capture as intent.md](https://academy.claude.com/courses/ai-native-sdlc-playbook/capture-intent)
  ([Requirements and design](https://academy.claude.com/courses/ai-native-sdlc-playbook/requirements-and-design)).
- GitHub spec-kit — [templates](https://github.com/github/spec-kit/tree/main/templates).

## Templates

Scaffold from `templates/` (next to this skill), then fill:

| asset | template |
|---|---|
| `intent.md` | `templates/intent-template.md` |
| `spec.md` | `templates/spec-template.md` |
| `plan.md` | `templates/plan-template.md` |
| `research.md` | `templates/research-template.md` |
| `tasks.md` | `templates/tasks-template.md` |

```bash
d=spec/001-slug; mkdir -p "$d"
for a in intent spec plan tasks; do cp <skill>/templates/$a-template.md "$d/$a.md"; done
# optional: research-template.md -> research.md
```

Templates contain `[PLACEHOLDERS]` and HTML comments; delete the comments and
replace every placeholder. Never ship a template unchanged.

## Order

1. `intent.md` — capture first; product owner approves before design.
2. `spec.md` — derive from the approved intent; resolve or carry forward open questions.
3. `plan.md` — design against `spec.md`, before tasks.
4. `research.md` — only if a decision needs evidence.
5. `tasks.md` — last; derived from `spec.md` + `plan.md`.

## intent.md

The raw ask, in the originator's own words. No user-story formalism and no
implementation detail.

- Header: author, timestamp, status `draft → approved`.
- `## Problem` — what hurts today, observed and concrete; no solution.
- `## Proposed outcome` — what better looks like.
- `## Affected users and systems` — who and what is touched.
- `## Constraints` — what must hold (privacy, security, compatibility, policy).
- `## Open questions` — unknowns the originator cannot answer yet.
- `## Approval` — product owner sign-off with name and date.

The product owner corrects anything that was misunderstood, then approves.
Write this once; do not rewrite history when the spec changes.

## spec.md

The feature specification derived from the approved intent. Mandatory, not a
cover page. Business-readable, no implementation detail.

- Header: `From: intent.md`, status `draft → agreed`.
- `## Summary` — what will be built and why.
- `## User Scenarios & Testing` — prioritized user stories (P1, P2…), each
  independently testable, with acceptance scenarios (`Given / when / then`);
  plus `### Edge cases`.
- `## Requirements` — `FR-001`, `FR-002`, …: testable, technology-agnostic.
  Mark genuinely unclear items `[NEEDS CLARIFICATION: question]` sparingly.
- `## Key entities` — if data is involved; meaning and attributes, not schema.
- `## Success criteria` — `SC-001`, …: measurable and technology-agnostic.
- `## Assumptions` — reasonable defaults chosen where the intent was silent.
- `## Open questions from intent` — answered, or carried forward with an owner.

Every constraint in the intent is either met by a requirement or recorded as
an open concern. If it reads like an implementation, it belongs in `plan.md`.

## plan.md

Technical detail. **No tasks, no phases, no "step 1".** Derived from `spec.md`.

- `## Requirement coverage` — map each `FR-xxx` to the component/interface that
  satisfies it.
- Data model, formats, paths, ownership.
- Statuses / states and transitions.
- Interfaces: commands, env vars, APIs, UI surfaces.
- Invariants and failure behavior.
- Delivery / concurrency / recovery rules.
- `## Open questions` — unresolved decisions only.

If it reads like a todo list, it belongs in `tasks.md`.

## research.md (optional)

Add only when a choice needs evidence: upstream capability, API behavior,
library drift, performance limits. Record question → findings → decision.
Delete or fold into `plan.md` once settled.

## tasks.md

All work, phased, tickable. Derived from the user stories and requirements in
`spec.md` plus the design in `plan.md`.

```markdown
# Tasks — omo app

## Phase 1 — take store (US1)
- [x] T001 [US1] durable take JSON + clips
- [x] T002 [US1] `last` / `show` / `copy` / `retry`
- [ ] T003 [US1] prune policy

## Phase 2 — delivery (US2)
- [ ] T004 [US2] send deadline
- [ ] T005 [US2] `sent_unconfirmed`
```

- Phase = shippable slice, not a file.
- One checkbox = one verifiable change.
- Every task tags a user story (`[US1]`); every story has at least one task.
- Tick as work lands; keep partial phases visible.
- Move dropped work to `## Later` with a reason, don't delete silently.

## Workflow

1. Pick next number: scan `spec/`, use highest `NNN` + 1 (`spec/002-slug/`).
2. Capture `intent.md` with the originator; get product-owner approval.
3. Derive `spec.md` from the intent; validate that requirements are testable,
   contain no implementation detail, and cover every intent constraint.
4. Write `plan.md` against the spec; resolve open questions or mark them.
5. Add `research.md` only if needed.
6. Derive `tasks.md`; implement phase by phase, ticking boxes.
7. Change code and spec together. Specs are the contract, not a diary.

## Lifecycle

- `intent.md`: `draft → approved`. `spec.md`: `draft → agreed`.
- Done specs stay in `spec/`; they are the record, not scaffolding.
- New intent supersedes old with a new folder; do not rewrite history.
- Failed or abandoned effort: keep the folder, mark status, note why in `tasks.md`.

## Rules

- Small files beat complete files.
- Intent says *what was asked for*; spec says *what was decided*; plan says
  *how*; tasks say *what*.
- No tasks in the plan; no implementation in intent or spec.
- Keep intent and spec as a pair; commit and version them together.
- Non-goals and constraints are as important as goals.
- Numbered folder, never loose spec files at `spec/` root.
