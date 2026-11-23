# M1 reference-product brief and target decision

Revision: 0, 2026-11-16. Scenario accepted by the owner; budgets and target recommendation are proposed. No implementation, hardware measurement, purchase or board qualification has occurred. This document owns the workload and target decision inputs for issue [#5](https://github.com/turlamai/kiln/issues/5).

## Useful outcome and boundary

The reference is a low-voltage evaluation node: acquire ADC samples, exercise a PWM output into a measurement fixture, exchange classic CAN frames and demonstrate bounded fault/reset recovery. It tests a credible embedded product workload without requiring motor control, FOC, an actuator or a safety-critical claim. It is an engineering reference, not a market-validated commercial product or a saleable hardware design.

The owner approved this scenario as the basis for M1. Specific board, wiring, component revisions and measured budgets remain open. UART carries local diagnostics; CAN requires a suitable physical transceiver and test peer. Do not infer that a CAN peripheral means an onboard transceiver or a ready-to-use bus connector.

## Observable behavior

| Scenario | Input / action | Expected outcome | Failure / recovery evidence |
| --- | --- | --- | --- |
| Startup | Power/reset with the measurement fixture attached | PWM remains disabled until initialization and input checks succeed; ready indication is explicit | Invalid configuration cannot enable the output; capture reset-to-ready timing |
| Sampling | One bounded ADC channel sampled periodically | Timestamped raw values enter a fixed-capacity buffer; transformations preserve declared integer semantics | Out-of-domain values produce a defined fault/result; no silent narrowing |
| PWM validation | Explicit enable and bounded duty command | A timer produces the configured waveform; application updates occur at the declared rate | Invalid duty rejected; fault deasserts the output-enable state |
| CAN exchange | Versioned test frames from a local peer | Bounded parsing, status response and explicit counters | Invalid lengths/IDs rejected; bus-off recovery policy and traces recorded |
| Load and overflow | Input burst beyond queue capacity | The declared drop policy and counter are observable | No overwrite of live objects, unbounded allocation or blocking in ISR |
| Reset and fault | Reset, watchdog and injected input/configuration fault | Output returns to the specified disabled state; bounded crash/reset reason is readable | No automatic resumption of an unvalidated command |

Raw peripheral operations remain in qualified C adapters; application sequencing, validation and bounded transformations are candidates for Racket. This is a responsibility split proposal, not an implemented API.

## Proposed budgets for review

These are engineering hypotheses for a small reference workload, **not measurements or universal platform limits**. Compare the same functionality and driver/toolchain inputs with a straightforward C baseline. Record total image cost and incremental Kiln cost separately. A failed target prompts a reviewed redesign, not a silent increase in thresholds.

| Budget | Proposed threshold | Reason / measurement method |
| --- | --- | --- |
| Flash | At most 256 KiB for application, runtime, selected drivers and constants | Leaves headroom on the smaller candidate; read final ELF load regions and linker map; exclude a separately budgeted bootloader explicitly |
| Static RAM | At most 64 KiB excluding reserved stacks and hardware-only regions | Fixed buffers and state must fit with headroom; sum actual sections by physical memory region |
| Stack | At most 8 KiB combined reserved task/main and interrupt stack for the initial bare-metal profile | Static call/interrupt review plus high-water measurement under nested fault/load cases; missing bounds remain unknown |
| Heap | No general dynamic allocation during device initialization or operation | Final symbol/dependency scan and reviewed transitive effect closure; static storage is an initial profile hypothesis |
| Sampling | One ADC channel at 1 kHz; processing completes before the next 1 ms period | Useful bounded workload; logic analyzer/timer traces with declared background traffic |
| PWM | 10 kHz carrier; application duty updates at most 1 kHz | Distinguish timer hardware generation from software deadlines; scope the waveform and fault transition |
| Interrupt response | At most 50 microseconds from the declared event to ISR entry under the specified load | Candidate budget, not WCET proof; define priorities, clock and measurement trigger before testing |
| ISR work | At most 10 microseconds for acknowledge/capture/enqueue on the reference path | Keep processing out of ISR; measure worst observed duration and separately review the bound |
| CAN | Classic CAN at 500 kbit/s; nominal offered load 100 frames/s; separately test saturation | Requires reviewed bit timing and physical setup; retain peer traces, queue policy and bus-off observations |
| Queue | 32 entries; drop newest on full with a monotonic overflow counter | Fixed capacity and explicit overload semantics; inject 64-entry bursts and counter rollover cases |
| Startup | Ready within 100 ms from the specified reset edge | Excludes host USB enumeration; scope actual output enable and ready signal |
| Recovery | Fault requests output disable within one sampling period when software remains executable | Abrupt clock/CPU/power failure needs a hardware-defined safe state; watchdog/reset recovery is a separate measured path |
| Soak | 1 hour at M2 integration; 72 hours for M3 qualification | Combine nominal traffic with scheduled overload/fault cases; counts, resets and lost samples must be explained |

Memory totals must fit the actual linker layout, not merely the aggregate SRAM advertised by the chip. Timing inputs include nested interrupts, critical sections, DMA/cache policy and SDK calls. The target decision must either confirm these budgets against measurements or replace them with a justified reviewed revision before M1 closes. No hard-real-time or physical safety guarantee is made.

## Two-board comparison

Official specifications were reviewed on 2026-11-16. These are desktop-research candidates; local possession, distributor stock, board revision and instrument access are unverified.

| Consideration | NUCLEO-F446RE | NUCLEO-F767ZI |
| --- | --- | --- |
| MCU family | STM32F446RE, Cortex-M4 with single-precision FPU | STM32F767ZI, Cortex-M7 with FPU and a more complex memory hierarchy |
| Published envelope | Up to 180 MHz, 512 KiB Flash, 128 KiB SRAM | Up to 216 MHz, 2 MiB Flash, 512 KiB SRAM including data TCM; other special regions need their own map |
| Debug / expansion | Nucleo-64 with integrated ST-LINK and expansion headers | Nucleo-144 with integrated ST-LINK and more expansion space |
| Fit for first profile | Smaller resource envelope makes overhead visible; simpler initial memory/cache analysis | More headroom, but cache/TCM/DMA ownership adds qualification work |
| Peripheral validation | Confirm actual ADC/PWM/UART/CAN pins and board conflicts from the exact schematic | Confirm the same; do not assume all SoC functions are simultaneously available |
| Open evidence | Exact board/probe revision, wiring, clocks, SDK and toolchain pins, stock and instruments | Same, plus explicit cache/TCM/DMA placement and coherency policy |

Sources: ST's [F446 device](https://www.st.com/en/microcontrollers-microprocessors/stm32f446re.html), [F767 device](https://www.st.com/en/microcontrollers-microprocessors/stm32f767zi.html), [F446 board](https://www.st.com/en/evaluation-tools/nucleo-f446re.html) and [F767 board](https://www.st.com/en/evaluation-tools/nucleo-f767zi.html) pages. Family-wide feature lists are not evidence of a particular board revision's connectors or transceiver.

**Provisional recommendation:** investigate F446RE first if available and if its pin/resource/toolchain constraints pass review; retain F767ZI as the comparison and potential fallback. This preference is an engineering inference from the resource/complexity tradeoff, not an accepted board selection. Do not widen the platform's advertised target list to include either board yet.

## Toolchain and license decision inputs

Evaluate [Arm GNU Toolchain](https://developer.arm.com/Tools%20and%20Software/Arm%20GNU%20Toolchain) for C/ELF/debug and a compatible OpenOCD/ST-LINK path. Record exact versions, checksums, host architecture, target triple, C standard, optimization, linker script, probe firmware and debug configuration before testing. No compiler, FPU ABI or clock tree is pinned by this document. The Racket host baseline remains CS 9.3.

STM32CubeF4/F7 are SDK candidates, not dependencies. ST's [F7 license summary](https://www.st.com/resource/en/data_brief/stm32cubef7.pdf) lists multiple component licenses; a permissive HAL entry does not license the whole package uniformly. Inventory only the startup/CMSIS/HAL/LL/BSP files actually needed, verify their license texts at the selected commits, and separate host tools from code linked into firmware. Avoid copying demonstration projects as a shortcut. Compiler runtime libraries and debug tools need their own notice/redistribution review. No third-party source is adopted in this slice.

## Decision gate

Before selecting a board, record possession/procurement facts, exact revision/schematic, pin allocation, power/transceiver/probe/instrument setup, memory layout, toolchain/SDK pins and per-file license inventory. Before M1 exit, add feasibility evidence for the proposed budgets, the ordinary-module compatibility cases and ADR 0003's runtime assumptions. Issue #5 remains open until that decision is supported; the brief alone does not qualify a target.

Field firmware update is not implemented or specified by the evaluation-node reset scenario. M3's update-recovery requirement still requires a separately reviewed boot layout, authentication, interrupted-write and recovery design; lack of that work blocks field-update and M3 completion claims.
