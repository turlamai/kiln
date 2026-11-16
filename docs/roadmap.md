# Stage-gated roadmap

Status: M0 complete; M1 framework/contract work in progress; M1 experiments and M2–M4 implementation unstarted. Milestone completion requires linked evidence and a maintainer review. Dates are intentionally unset until scope and hardware budgets are established.

| Milestone | Outcome | Exit criteria |
| --- | --- | --- |
| M0 — Architecture foundation | Reviewable repository, contracts and governance | Bilingual entry, ADRs, risk/requirements/validation map, issue queue, three-host foundation CI and main protection verified |
| M1 — Feasibility and contracts | Prove ordinary Racket can enter a sound restricted pipeline | Product brief and numeric budgets; board/toolchain/license decision; imported macro and phase experiments; accept/reject corpus; IR/ABI/evidence schema proposal; reviewed go/no-go |
| M2 — First native vertical slice | One inspectable path from module to board | Validated IR, semantics-preserving C, minimum runtime/BSP, UART/timer/GPIO, source debugging, positive and rejection differential tests, map/ELF resource gate |
| M3 — Reference product qualification | Useful embedded product with bounded claims | ADC/PWM/CAN workload as required by brief, C baseline comparison, explicit deadline/stack/Flash/RAM budgets, faults/update recovery, soak, HIL, three-host reproducibility and independent review |
| M4 — SDK release readiness | Repeatable supported distribution | Versioned compatibility matrix, package dependency/docs gates, signed artifacts/provenance, SBOM/license review, clean use/recovery, documented security/support and all blocker closure |

## Sequencing

Only the next bounded slice is active. Current owner direction is to establish the framework before implementation: review the reference-product brief, compatibility procedure, proposed evidence format and case matrix first. Do not implement probes, compiler passes or device runtime in this slice. After the owner advances the scope, run the defined M1 experiments and review their evidence before freezing layouts or widening support. M2 admits only the smallest profile needed to demonstrate an end-to-end path; it must still reject unsupported code correctly.

After M4, evaluate a second board/vendor, RISC-V or a single RTOS adapter based on product demand. A VM, direct backend and AUTOSAR integration each need a separate feasibility decision. They are not promised deliverables. No GUI is required for the first SDK; any future interface begins with the family's prototype-first process.

If an exit criterion fails, document the counterexample, revise the relevant ADR/contract and rerun affected evidence. No phase closes through a prose status update alone. A green foundation workflow does not close M1 or qualify a board.
