# Risk register

Status: open investigation baseline. Severity expresses consequence, not a measured probability. The repository maintainer owns routing; each linked issue owns an experiment.

| ID | Severity / risk | Mitigation and falsification experiment | Blocks |
| --- | --- | --- | --- |
| R-01 | Critical: accepted Racket silently changes semantics | Binding-aware differential corpus including overflow, truth, evaluation order, initialization and tail calls; reject unresolved cases | M1/M2 |
| R-02 | High: ecosystem reuse shrinks to a dialect in practice | Test ordinary modules and representative third-party host macros; publish phase-specific compatibility and rejection reasons | M1 |
| R-03 | Critical: bounded arithmetic/memory analysis is unsound | External-input validation, adversarial range/lifetime cases, independent oracle and verifier mutation tests | M2 |
| R-04 | Critical: C undefined behavior creates miscompilation | Explicit sequencing/conversion, host sanitizers and optimization/toolchain comparisons, target review | M2/M3 |
| R-05 | Critical: ISR, DMA or scheduler violates deadlines/data integrity | Context closure analysis, explicit synchronization/cache policy, measured nested-interrupt workloads | M3 |
| R-06 | High: expansion executes hostile code or reads ambient secrets | OS isolation, pinned inputs, restricted resources/network and scrubbed output-side bundles | M1 |
| R-07 | High: SDK/compiler licensing contaminates distributed runtime | Per-artifact license inventory before adoption; no copying research implementations; separate host and device SBOMs | M1/M4 |
| R-08 | High: host builds or hardware evidence cannot be reproduced | Three-host clean build comparison, exclusive HIL leases, immutable manifests and retained digests | M3/M4 |
| R-09 | High: excessive scope prevents a real product | One profile/backend/board/product; stage exits and a stop/replan decision after failed experiments | Every phase |
| R-10 | Critical: firmware update/fault leaves unsafe device | Product-defined safe state, watchdog, power interruption and recovery matrix | M3 |
| R-11 | High: brand/package availability is mistaken for legal clearance | Scoped name check now; trademark/domain and distribution review before public commercial launch | M4 |
| R-12 | High: sole-maintainer review and hardware capacity | Do not invent independent approval; obtain qualified independent review before production qualification, keep small slices | M3/M4 |

Stop and revise the architecture if ordinary-module expansion cannot preserve bindings/phases, the initial profile requires unbounded runtime behavior, resource budgets cannot be met without semantic changes, or a redistributable hardware/toolchain path cannot be established. These are go/no-go criteria, not reasons to conceal unsupported behavior.
