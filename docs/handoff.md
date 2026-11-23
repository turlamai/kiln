# Implementation handoff

## Current bounded outcome

M0 is complete with [foundation evidence](https://github.com/turlamai/kiln/issues/4). M1 is establishing the framework and contracts only, following the owner's 2026-11-16 direction to defer implementation. No compiler, runtime, hardware support or production-readiness claim is authorized by a green documentation check. GitHub Issues and milestones own task state; the [roadmap](roadmap.md) owns phase exits.

This slice starts at `cdf044f77b939c5e93ca9dc0b33239e4bd0b952f`, branch `m1/compatibility-boundaries`. Policy revision actually reread: `b4e3d9fec4c20c152738c736b9b19de1b7b91efa`; reference snapshots are in [survey](repository-survey.md). The PR and issues #5/#6/#7 record validation and remaining work.

Accepted policy: default `racket/base` plus ordinary `require`; judge actual semantics/effects/resources, with neither full base nor full `racket` coverage as a goal. The host retains full Racket tooling. Accepted reference scenario: low-voltage ADC/PWM/CAN evaluation node with fault/reset recovery; no motor control or hazardous load. Budgets, exact board selection, toolchain/SDK pins and ABI layouts remain proposed.

Canonical additions: [reference-product brief](reference-product.md), [compatibility assessment](compatibility-assessment.md) and [evidence contract](evidence-contract.md). The case matrix is unrun. No probe, compiler pass, runtime, schema validator or hardware experiment has been implemented.

## Next bounded slice

Continue framework review in [#5](https://github.com/turlamai/kiln/issues/5): review the proposed budgets, establish exact board possession/revision and pin/peripheral constraints, and complete the target/toolchain/license decision dossier without claiming measurements. F446RE and F767ZI are comparison candidates; the provisional F446RE preference is not board selection.

Use [#6](https://github.com/turlamai/kiln/issues/6) and [#7](https://github.com/turlamai/kiln/issues/7) to review the planned host/target phase cases, missing graph/provenance obligations and evidence field rules. The next framework work can specify manifest/FFI and fault contracts in their existing canonical owners. Implementation or executable experiments wait until the owner advances that scope; the existing docs/checker/package gates continue to validate documentation only. No hardware purchase, release or measurement is implied.

At the start, inspect git status and worktrees, update a clean branch with `git pull --rebase`, re-read AGENTS, current policies and the assigned issue. Record starting SHA, policy SHA, exact scope and active-writer declaration in the issue. Use an isolated worktree for simultaneous same-machine sessions. Preserve others' work. Finish with focused evidence, updated canonical contracts, commit/push and a single next handoff; watch affected CI until green.

## Bootstrap verification boundary

The executable suite checks the documentation foundation. Planned semantic, ABI, hardware, reproducibility and release checks remain unrun. A later agent must not reinterpret the present CI badge or package install as target validation. Main protection requires the stable aggregate `Foundation gate`; no independent reviewer is fabricated for a sole-maintainer repository.
