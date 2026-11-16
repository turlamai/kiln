# ADR 0003: Bound the first runtime and target

Status: Proposed

Date: 2026-11-16

## Context

No reference product, board or numeric resource budget has yet been qualified. General Racket values and arbitrary dynamic behavior cannot be assumed affordable.

## Decision

Investigate an allocation-free bounded-stack profile and one bare-metal Cortex-M4/M7 board. Require range-proven arithmetic or faithful implementations; otherwise reject. Separate hardware API, execution adapter and BSP. Select layouts and exact hardware only after M1 evidence.

## Alternatives

Starting with a general heap/GC, multiple RTOSes or several vendors would multiply unverified boundaries. Forcing all values to 32-bit arithmetic would violate the language contract.

## Consequences

Closure, number, recursion and initialization coverage may be narrow initially. If a real product cannot fit without silent semantic changes, revise this proposal or stop. Acceptance requires a product brief, target/license comparison, profile corpus and reviewed runtime/ABI experiment.
