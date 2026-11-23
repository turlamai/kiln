# Racket compatibility contract

Status: source policy accepted, clarified 2026-11-16; proposed profile `core-static-0` is unimplemented. No current source input can be compiled to an MCU by Kiln.

## Compatibility rule

The default source entry is `#lang racket/base`, with ordinary `require` for additional libraries. Neither complete `racket/base` coverage nor complete `racket` coverage is a platform goal. Compatibility is determined by actual semantics, transitive runtime effects and resource obligations, not by the language name or library membership. Host expansion, development tools, tests and documentation retain the full host Racket ecosystem.

Kiln accepts a program only if its reachable runtime operations and required module initialization are covered by a declared profile and its resource obligations are discharged for the named target/input domain. It preserves Racket behavior for accepted executions or emits a diagnostic explaining why it cannot. A profile restricts accepted programs, not the meaning of accepted Racket operations. Unsupported inputs must never silently fall back to host execution or be approximated as C behavior.

`racket/base` is not a static-memory or real-time language variant. A module using it may still require unsupported allocation, continuations or OS behavior. Conversely, a library outside it may expand to operations that the target profile supports. `racket/match`, for example, is eligible for evaluation; this is not a current support claim. Do not whitelist everything in base or blacklist everything outside base.

Accepting `#lang racket` as a future convenience requires its own dependency/initialization evidence. Merely accepting that spelling would not promise the combined library's runtime features. No implementation phase is required to pursue it.

The operational decision sequence and cases live in [compatibility assessment](compatibility-assessment.md); this document remains the normative owner of language meaning.

| Feature | Proposed initial treatment | Required positive/negative evidence |
| --- | --- | --- |
| Official reader, macros, modules | Host expansion with phase graph | Imported/renamed/shadowed bindings and macro origins |
| Booleans and conditionals | Preserve Racket truth: only `#f` is false | Zero and empty list remain true |
| Exact integers | Range-proven operations or faithful runtime; otherwise reject | Target bounds, overflow chain, division and negative operands |
| Fixed-width device values | Explicit ordinary library bindings with documented wrap/check rules | Boundary conversion and signedness tests |
| Argument evaluation | Preserve left-to-right effects | Conflicting writes and FFI calls |
| Multiple values | Explicit arity in IR; first slice may reject beyond one value | Wrong arity rejected without dropping values |
| Closures | First slice investigates nonescaping, statically resolvable closures | Escaping environment rejected until lifetime support exists |
| Tail calls | Explicit tail edges; bounded-stack lowering required | Long-running mutual recursion with stack evidence |
| Mutation and aggregates | Explicit ownership and bounded lifetime before admission | Aliasing, bounds and mutation order tests |
| Module initialization | Explicit ordered graph; unsupported cycles/effects rejected | Once-only initialization and early access failures |
| Inexact numbers | Deferred pending target/host floating-point contract | NaN, infinities, rounding and FPU modes |
| General allocation and GC | Deferred; no allocator in critical paths | Reachable indirect allocation rejected |
| Exceptions and continuations | Deferred, reject reachable operations | No mapping to unchecked `longjmp` or C return values |
| Threads, parameters, dynamic loading, eval, host FFI and OS ports | Reject target use until an explicit profile exists | Transitive dependency and initialization rejection |

## Analysis rules

Binding identity and phase determine an operation, not its spelling. All reachable callees and initialization effects participate in the profile check. Unknown indirect targets, effectful reflection and unproved termination/resource facts remain unknown and cannot be reported safe. Conservative rejection is acceptable; unsound acceptance is not.

The declared entry points and their input domains are build inputs. A range proof depends on validated ingress checks, including FFI inputs and interrupt-originated data. It cannot assume that an ADC value, pointer or caller obeys a contract without enforcing or qualifying that boundary. Runtime contract failures have a defined fault path; they cannot trigger C undefined behavior.

## Diagnostics

Planned diagnostics carry a stable code, severity, source path/line/column, macro origin when known, importing dependency chain, profile, rejected binding/effect and actionable explanation. Distinguish unsupported semantics from malformed code and missing toolchain inputs. Paths are scrubbed in shareable reports. No success output may coexist with a rejected semantic operation.

## Package compatibility

Publish compatibility per package checksum, exported binding, runtime profile and target, separately from host macro compatibility. A package compiling successfully on desktop Racket does not establish device compatibility. Do not promise drop-in use of Typed Racket, contracts, classes, FFI or networking packages. Existing packages are evaluated binding by binding, without forking them into a new ecosystem.

The official [syntax model](https://docs.racket-lang.org/reference/syntax-model.html) and [module phases](https://docs.racket-lang.org/guide/phases.html) define the host model. Their use does not supply a target runtime automatically.
