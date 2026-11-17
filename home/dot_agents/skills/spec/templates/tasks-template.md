# Tasks — [FEATURE NAME]

`spec/[NNN-slug]` · draft · spec: `spec.md` · plan: `plan.md`

<!--
  All work, as phased checkboxes. Derived from the user stories and
  requirements in spec.md plus the design in plan.md. One task = one
  verifiable change. Phase = shippable slice, not a file. Tick as work lands.
-->

## Phase 1 — [slice name] (US1)

**Goal**: [What this phase delivers.]
**Checkpoint**: [How to verify it on its own.]

- [ ] T001 [US1] [Concrete change, with path.]
- [ ] T002 [P] [US1] [Independent change; can run in parallel.]
- [ ] T003 [US1] [Follow-up that depends on T001.]

## Phase 2 — [slice name] (US2)

**Goal**: [What this phase delivers.]
**Checkpoint**: [Verification.]

- [ ] T004 [US2] [Concrete change.]
- [ ] T005 [US2] [Concrete change.]

## Later

- [ ] [Deferred work, with reason.]

## Notes

- `[P]` = parallel: different files, no dependency.
- `[US1]` = user story from `spec.md` the task serves; every task has one.
- Keep task ids stable; add new ones, do not renumber.
- Change code and spec together; update the plan if behavior changes.
- Tick a task only when its verification passes.
