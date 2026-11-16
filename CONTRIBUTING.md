# Contributing

Kiln is in architecture foundation. Begin with the [documentation map](docs/README.md), [handoff](docs/handoff.md) and an issue describing one bounded outcome. Architecture direction changes need an ADR with context, alternatives, consequences and evidence. Do not begin compiler implementation before M1 review.

Use English for reusable technical documents, issues, PRs and code comments. Keep README and getting-started Chinese paths complete and consistent. Technical contracts have one normative English owner. Prefer standard Racket facilities and existing packages; record reuse and license decisions before adding dependencies.

## Local validation

Use full Racket CS 9.3. Follow [getting started](docs/getting-started.md) to link the documentation package, then run:

```sh
racket kiln-tools/check-foundation.rkt
raco test kiln-test
raco setup --check-pkg-deps --pkgs kiln
raco scribble --htmls --dest build/manual kiln-doc/kiln.scrbl
```

Every foundation PR needs all three host jobs and `Foundation gate`. These checks do not test an MCU. Later behavioral changes need focused regression tests, positive and rejection evidence, and relevant output artifacts as specified in [validation](docs/validation.md). Do not refresh baselines or lower thresholds simply to pass.

## Collaboration and review

Inspect the worktree and remote before editing; update clean work with `git pull --rebase`. Preserve existing changes. Same-machine concurrent sessions use separate worktrees. Declare a shared-layer write in the issue, include source/policy SHAs and scope, and push small coherent commits. Never hand-resolve generated lockfiles; regenerate from the reviewed inputs.

Explain the problem, resulting behavior, contract ownership, validation and remaining limits in a PR. The maintainer reviews scope, risks, license boundaries and evidence. A sole maintainer may merge a checked small slice without a fictional second reviewer; production qualification requires independent expertise. Report vulnerabilities privately through [Security](SECURITY.md). Contributions are accepted under the repository MIT license; no CLA or additional rights transfer is required.
