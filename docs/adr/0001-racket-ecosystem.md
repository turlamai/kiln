# ADR 0001: Keep Racket as the source ecosystem

Status: Accepted

Date: 2026-11-16

## Context

The platform must reuse Racket packages, macros, modules and tools rather than create another MCU Scheme dialect. Desktop compatibility alone cannot establish target runtime feasibility.

## Decision

Accept ordinary `#lang racket/base` modules through official reading/expansion, retain resolved bindings and phases, and classify reachable target capabilities explicitly. Unsupported behavior is rejected with provenance. Use standard packages and host RackUnit/Scribble workflows.

## Alternatives

A custom `#lang` would simplify restrictions but change the ecosystem promise. A new parser would duplicate hygiene/module semantics. A full Racket runtime port has a different resource and OS burden. None is the selected initial path.

## Consequences

Host macro execution needs isolation. Package compatibility is phase/binding-specific. Prove expanded-module extraction and diagnostics before implementation breadth. This decision does not promise all Racket programs or packages on devices.
