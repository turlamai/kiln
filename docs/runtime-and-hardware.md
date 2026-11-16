# Runtime, ABI and hardware boundaries

Status: proposed obligations; no runtime, ABI layout, BSP or board is implemented.

## Runtime contract

Separate semantic values from physical representations. Initial experiments compare range-proven unboxed integers with a small tagged representation; no layout is selected yet. Record sizes, alignment, target endianness, pointer width, C compiler ABI, FPU mode and calling convention in the target manifest. Do not serialize native structs as a stable wire format.

The first profile aims for static storage and bounded stack. No general heap, collector, implicit host service or background task is assumed. If a feature needs allocation, its admission requires a new explicit profile and evidence. Tail-recursive execution must remain bounded in stack; indirect calls require complete effect summaries. Startup initializes runtime state, board resources and modules in a documented order before enabling application interrupts.

## C boundary obligations

Every imported/exported symbol declares argument/return representation, arity, ownership, lifetime, nullability, bounds, alignment, thread/ISR context, reentrancy, allocation, blocking and failure behavior. A borrowed buffer cannot outlive its call unless an explicit transfer contract exists. Callbacks cannot retain stack objects or enter an unsupported runtime context. C drivers are trusted components with qualification evidence; an annotation alone does not prove their behavior.

Signed overflow, invalid shifts, unsequenced effects, strict aliasing and misaligned access must not be emitted as implementations of valid Racket behavior. Sanitizers on the host and compiler diagnostics support this review; they do not prove absence of target-specific undefined behavior.

## Hardware layers

| Layer | Contract |
| --- | --- |
| Hardware API | Explicit handles, configuration, pin ownership, bounded transfers and timeout/failure results |
| Bare-metal/RTOS adapter | Scheduling, interrupt entry/exit, critical sections, event handoff and time base |
| BSP/SoC | Part/board revision, vectors, reset, clocks, linker memory regions, pins and peripheral mappings |

Reuse licensed vendor C drivers or a qualified OS adapter instead of recreating drivers. A board manifest pins SDK source/version/digest, license, probe, flash tool, clocks, compiler/linker options, memory regions and reserved bootloader areas. Register access is explicit through reviewed volatile/barrier primitives. `volatile` does not make shared state atomic; specify interrupt masking or atomics, memory order and DMA cache maintenance where applicable.

ISR code has a separate allowed-call closure: no allocation, blocking, unbounded recursion or unqualified callback. Task/ISR transfers use fixed-capacity queues with overflow policy and tests. Interrupt priority, nesting, stack separation and cache/bus effects belong to the named target qualification, not a universal language guarantee.

## Faults and recovery

Bounds violations, invalid foreign input, stack/resource exhaustion and unsupported runtime states enter a defined fault hook. Preserve a bounded crash record and invoke the product's safe-state/reset policy; do not resume corrupted state. The product owns hazard analysis, watchdog policy and update trust. Firmware signing keys are distinct from host-tool release keys and product entitlement keys. Power-loss-safe update slots, rollback and recovery are required for a product claiming field update support; they are not implemented by this foundation.
