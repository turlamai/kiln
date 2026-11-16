# System requirements

Status: proposed acceptance baseline; no compiler or target implementation exists.

## Product definition

Kiln enables developers to produce inspectable, reproducible MCU firmware from supported ordinary Racket modules. The first customer is a real embedded product developed with the platform. Blinking an LED proves a pipeline connection, not production readiness. The initial product brief must identify useful workloads, hardware, failure consequences and quantitative budgets before optimization begins.

| ID | Requirement | Acceptance evidence | Gate |
| --- | --- | --- | --- |
| REQ-001 | Use official reading/expansion, binding identity and module phases | Imported macro, renamed binding, shadowing and phase tests | M1 |
| REQ-002 | Preserve supported Racket observable semantics; reject the remainder | Positive/negative corpus and differential results | M1–M2 |
| REQ-003 | Use standard package dependency resolution | Locked transitive graph split by host/target phase | M1 |
| REQ-004 | Validate every IR boundary before code emission | Malformed IR rejection, invariant and pass tests | M2 |
| REQ-005 | Define allocation, stack, lifetime and fault behavior | Resource report and fault-injection evidence | M2–M3 |
| REQ-006 | Separate hardware API, adapter and board configuration | First board manifest and isolated adapter tests | M2 |
| REQ-007 | Build equivalent firmware on three development OSes | Independent artifact digests and environment manifests | M3 |
| REQ-008 | Debug target failures back to Racket locations | Source-map, debug session and crash trace artifact | M2–M3 |
| REQ-009 | Bound claimed real-time paths on named hardware | Stack/interrupt measurements and bounded-path review | M3 |
| REQ-010 | Recover from interrupted update and watchdog/reset faults | Power-loss matrix, recovery procedure and HIL traces | M3 |
| REQ-011 | Trace release claims to immutable evidence and licenses | SBOM, provenance, CI/HIL reports and signed manifest | M4 |
| REQ-012 | Keep devices offline and free of platform licensing services | Dependency audit; product commerce stays outside runtime | M4 |

## First target decision inputs

Cortex-M4/M7 with a bare-metal adapter is the initial investigation envelope, not a support commitment. Compare at least two obtainable boards for debug probes, open toolchains, documented clocks/interrupts, SDK redistribution rights, RAM/Flash headroom and access to UART, timer, ADC, PWM and CAN. Exact board, part revision, floating-point ABI and clock tree remain open until M1 evidence is reviewed. Existing STM32 experience is useful evidence, not sufficient selection justification.

The first product brief must record Flash/RAM/stack ceilings, interrupt-latency limit, control deadline, fault-safe state, startup duration, update/recovery mechanism, soak duration and C baseline workload. Each value needs a rationale and measurement method. Missing values block M1 exit; this document does not invent target guarantees.

## Exclusions

No whole-Racket runtime port, new source dialect, parallel package manager, GUI, VM, direct machine-code backend, multi-RTOS matrix, certified toolchain or cloud service in the first implementation phase. No functional-safety claim follows from using C or passing CI. Industry qualification is a separate, product-specific program.
