# ADR 0002: Native C through verified representations

Status: Accepted

Date: 2026-11-16

## Context

Commercial embedded products need inspectable output, established cross-toolchains, debugging and a sustainable board integration path.

## Decision

Use semantic IR, resource IR and an explicit C representation with verifiers between stages. Generate C for a pinned cross-toolchain. Preserve Racket semantics rather than inheriting unchecked C behavior. This fixes the layering, not SSA, serialization or data layouts.

## Alternatives

Direct textual source-to-C skips essential semantic boundaries. A VM adds an execution engine and timing surface. A direct native backend adds code-generation complexity before product evidence. Existing restricted-language compilers remain research candidates, not automatic semantic substitutes.

## Consequences

C undefined behavior, ABI constraints and debug provenance need dedicated proof and tests. Native output does not establish real-time guarantees. No second backend begins before a useful product validates the first.
