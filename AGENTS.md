# Kiln maintainer contract

At every bounded slice read this file, [documentation map](docs/README.md), [handoff](docs/handoff.md), the assigned issue, and current family [delivery](https://github.com/turlamai/turlamai.github.io/blob/master/docs/PRODUCT-STANDARD.md), [languages](https://github.com/turlamai/turlamai.github.io/blob/master/docs/DOCUMENTATION-LANGUAGES.md) and [portfolio](https://github.com/turlamai/turlamai.github.io/blob/master/PORTFOLIO.md) policies. Record starting repository and policy SHAs in the issue/PR. Preserve others' dirty worktrees; use isolated worktrees for concurrent sessions. Declare shared-layer writing in the issue before editing and push coherent commits promptly.

## Invariants

- Source ecosystem is ordinary Racket with official expansion and standard packages. No new dialect or package manager.
- Host implementation is Racket; the device/runtime and first backend use C. No compiler implementation before M1 feasibility review. No hidden changes to Racket semantics to satisfy resource budgets.
- This is architecture foundation, with no working compiler or qualified target. Preserve truthful status in both public languages.
- Contracts live in their owners listed in the documentation map. Issues own task state; ADRs own decisions. Do not duplicate queues or chat history.
- No family source vendoring, product paywalls, issuer keys or company/private project information. Dependencies require catalog/reuse and license review.
- GUI work, if later authorized, follows the family's prototype-first Rivet/Glaze workflow. No GUI in this bootstrap.

## Checks and completion

Run `racket kiln-tools/check-foundation.rkt`, `raco test kiln-test`, `raco setup --check-pkg-deps --pkgs kiln` and the Scribble command in [getting started](docs/getting-started.md). The package must first be linked as documented. CI runs the same foundation on macOS, Windows and Linux; the required aggregate is `Foundation gate`. Never count skipped/cancelled/unrun jobs as passes. Future compiler/hardware work adds the corresponding [validation gates](docs/validation.md), including output-side red/green checks, before making claims.

Update contracts and bilingual user promises in the same change. Finish with evidence, changelog where relevant, the next bounded handoff, commit and push; follow affected CI to green. No release publication, force push or destructive history changes without owner approval.
