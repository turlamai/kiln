# Implementation handoff

## Current bounded outcome

M0 is the repository foundation. No compiler, runtime, hardware support or production-readiness claim is authorized by a green documentation check. GitHub Issues and milestones own task state; the [roadmap](roadmap.md) owns phase exits.

Bootstrap starting state: new repository, no starting commit. Policy revision actually read: `b4e3d9fec4c20c152738c736b9b19de1b7b91efa`; reference snapshots are in [survey](repository-survey.md). Bootstrap validation and GitHub settings are recorded in the M0 tracking issue after checks finish.

## Next bounded slice

Start the M1 product/target brief issue. Produce a concrete reference-product workload, quantitative resource/deadline/fault budgets and comparison of two obtainable Cortex-M boards/toolchains with licensing/debug evidence. In parallel only in the scheduling sense, the following slice can investigate official expansion on a small ordinary-module corpus. Do not freeze IR layouts or build a compiler before the feasibility review. No hardware purchase or external publication is implied.

At the start, inspect git status and worktrees, update a clean branch with `git pull --rebase`, re-read AGENTS, current policies and the assigned issue. Record starting SHA, policy SHA, exact scope and active-writer declaration in the issue. Use an isolated worktree for simultaneous same-machine sessions. Preserve others' work. Finish with focused evidence, updated canonical contracts, commit/push and a single next handoff; watch affected CI until green.

## Bootstrap verification boundary

The executable suite checks the documentation foundation. Planned semantic, ABI, hardware, reproducibility and release checks remain unrun. A later agent must not reinterpret the present CI badge or package install as target validation. Main protection requires the stable aggregate `Foundation gate`; no independent reviewer is fabricated for a sole-maintainer repository.
