# Compatibility assessment procedure

Revision: 0, proposed procedure, 2026-11-16. Source policy is accepted in [ADR 0001](adr/0001-racket-ecosystem.md); the case matrix below is planned and unrun. This document operationalizes the [language contract](language-contract.md), without defining a new language or an implemented compiler.

## Decision unit and inputs

Assess a build of a particular module graph and entry-point/input-domain contract, not an entire language name or package in isolation. Inputs include source/dependency checksums, Racket host version, phase graph, entry points, profile revision, target layout, C boundary contracts and resource budgets. Missing inputs remain unknown and cannot produce target admission.

Keep three results separate: **host expansion eligibility**, **target semantic coverage**, and **target resource qualification**. A host macro can use a rich library and emit supported operations. A runtime initializer in an apparently unused imported module can introduce effects that must still be accounted for. Module imports alone are not a complete call/effect closure.

## Review sequence

1. Resolve dependencies with standard Racket mechanisms; pin inputs and classify executable host build hooks. Confirm the trust/isolation plan before reading/expanding code.
2. Use official reading/expansion; preserve binding identity, phase shifts, module identity and source/macro provenance. Never identify primitives solely by spelling.
3. Determine required module initialization and reachable runtime operations, including indirect calls, callbacks and external ingress. Record uncertainties and effect summaries.
4. Match every operation against the named semantic profile. Check truth, arithmetic, arity, evaluation order, tail position, lifetime and failure semantics independently of representation choices.
5. Discharge allocation, stack, synchronization, ISR-context and target-layout obligations for the declared domain. Values from hardware/FFI need enforced bounds; host assumptions cannot substitute for target facts.
6. Produce a traceable decision and evidence links. If any required fact is unresolved, do not emit a usable firmware artifact. A future runtime check is allowed only when explicitly included in the profile, fault behavior and resource budget; it cannot hide an unsupported operation.

Results are `admitted`, `rejected` or `unresolved`. Only `admitted` allows code emission in a future compiler. `rejected` identifies a demonstrated contract incompatibility; `unresolved` identifies missing analysis or evidence. Both block emission. During the present framework phase every device-admission claim is unverified regardless of the case's intended future result.

## Planned case matrix

| ID | Input distinction | Future observation / oracle | Present status |
| --- | --- | --- | --- |
| CAP-001 | `racket/base` pure bounded arithmetic | Exact results match desktop Racket; range/ingress proof and resource evidence required | Unrun |
| CAP-002 | Same language, arithmetic exceeds proved range | Faithful implementation or reject; no implicit C overflow | Unrun |
| CAP-003 | Base module reaches allocation, continuations or host I/O outside the profile | Reject with binding/effect and dependency path | Unrun |
| CAP-004 | Base plus an imported macro, including candidate `racket/match` use | Check the actual expansion, initialization and effects; neither automatic admission nor blanket library rejection | Unrun |
| CAP-005 | Renamed primitive versus same-spelled lexical binding | Official binding identity distinguishes them; compare behavior with desktop Racket | Unrun |
| CAP-006 | Host `for-syntax` helper uses richer libraries | Host eligibility and target closure recorded separately; no host dependency mistakenly linked into firmware | Unrun |
| CAP-007 | Imported/transitive phase-0 initializer performs an unsupported effect | Do not erase the effect merely because an export is unused; reject or establish a semantic proof for elimination | Unrun |
| CAP-008 | Macro creates a rejected target operation | Diagnostic retains source/macro origin and dependency route | Unrun |
| CAP-009 | Unresolved indirect callee or foreign callback | Unknown effects/resources block admission; an annotation alone is insufficient proof | Unrun |
| CAP-010 | Tail-recursive or mutually recursive cycle | Bounded-stack lowering must preserve tail semantics; C optimization is not evidence | Unrun |
| CAP-011 | Zero/empty list, multiple values and effectful argument order | Compare observable results/arity/ordering with Racket; only `#f` is false | Unrun |
| CAP-012 | Host fixnum/FPU properties differ from target | Reject or lower against explicit target facts; no host-dependent folding | Unrun |
| CAP-013 | Same code has different ISR/task entry contexts | Recompute transitive context, blocking, allocation and synchronization obligations | Unrun |
| CAP-014 | Source declares `#lang racket` | No support commitment; an optional future entry requires full dependency/initialization assessment, not full-library coverage | Unrun |

The table is an acceptance design, not a claimed passing corpus. Later fixtures must retain positive and negative controls, independent expected observations and minimized counterexamples. Do not implement a library-name allowlist and call it this procedure.

## Boundaries still needing experiments

Official APIs to evaluate include `expand`, `identifier-binding` and `module-compiled-imports`. The last reports explicit imports grouped by phase shift; it does not establish a complete transitive runtime/effect graph. Compile-time phases, macro origins, submodules, cross-phase persistence, module cycles and dynamic dependencies need explicit coverage. A naive recursive syntax walk is not a production frontend and cannot prove initialization or resource safety.

References: official [syntax/binding model](https://docs.racket-lang.org/reference/syntax-model.html), [identifier bindings](https://docs.racket-lang.org/reference/stxcmp.html), [module imports](https://docs.racket-lang.org/reference/Module_Names_and_Loading.html), and [base versus combined library](https://docs.racket-lang.org/reference/index.html). These define host behavior, not an MCU backend.

Issue [#6](https://github.com/turlamai/kiln/issues/6) owns future expansion/reuse investigations; [#7](https://github.com/turlamai/kiln/issues/7) owns the combined profile/IR/ABI review. The current authorization prepares their framework only. No experiment, complete call graph, compatibility classifier or rejection diagnostic has been implemented.
