# Spec — [FEATURE NAME]

`spec/[NNN-slug]` · draft · [DATE] · From: `intent.md` ([author])

<!--
  Feature specification derived from the approved intent.md. This is the
  contract engineering plans against — the central mandatory artifact, not
  a cover page. Focus on WHAT users need and WHY. No implementation detail:
  no languages, frameworks, APIs, file paths, or data-model internals.
  Written for business stakeholders. Every requirement must be testable.
-->

## Summary

[One or two sentences: what will be built and why, drawn from intent.md.]

## User Scenarios & Testing

<!--
  Prioritize as user journeys ordered by importance (P1 first). Each story
  must be independently testable: implementing just one still delivers value.
-->

### User Story 1 — [Title] (Priority: P1)

[Describe the user journey in plain language.]

**Why this priority**: [Value and why it has this priority.]

**Independent test**: [How this can be tested on its own and the value it delivers.]

**Acceptance scenarios**:

1. **Given** [state], **when** [action], **then** [outcome].
2. **Given** [state], **when** [action], **then** [outcome].

### User Story 2 — [Title] (Priority: P2)

[Describe the user journey in plain language.]

**Why this priority**: [Value and why it has this priority.]

**Independent test**: [How this can be tested on its own.]

**Acceptance scenarios**:

1. **Given** [state], **when** [action], **then** [outcome].

### Edge cases

- What happens when [boundary condition]?
- How does the system handle [error scenario]?

## Requirements

<!--
  Testable and technology-agnostic. Use reasonable defaults for unspecified
  details and record them under Assumptions. Mark only genuinely unclear
  items with [NEEDS CLARIFICATION: specific question].
-->

- **FR-001**: System MUST [specific capability].
- **FR-002**: Users MUST be able to [key interaction].
- **FR-003**: System MUST [data or behavior requirement].
- **FR-004**: System MUST [NEEDS CLARIFICATION: what is unclear?].

## Key entities

- **[Entity]**: [what it represents; key attributes, no implementation detail.]
- **[Entity]**: [relationships to other entities.]

## Success criteria

- **SC-001**: [Measurable, technology-agnostic outcome, e.g. "users complete X in under 2 minutes".]
- **SC-002**: [Measurable outcome, e.g. "90% of users succeed on the first attempt".]

## Assumptions

- [Reasonable default chosen where the intent was silent, e.g. "existing authentication is reused".]
- [Dependency on an existing system or service.]

## Open questions from intent

- [Question from intent.md] — answered: [answer] / carried forward: [owner or reason].
