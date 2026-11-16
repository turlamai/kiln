# Repository and ecosystem survey

Reviewed 2026-11-16. This records observations and bounded judgments, not runtime qualification.

## Identity and permission

Authenticated owner `turlamai` is a GitHub **User**, not an Organization. The account's organization listing returned no memberships. All three requested references are under `turlamai`, and the authenticated account has ADMIN permission on them. The repository therefore uses that same namespace; no organization is invented or created. Creation and configuration are verified against the resulting repository, not inferred from the reference permissions.

Scoped repository search found no `turlamai/kiln`; `raco pkg catalog-show kiln` found no package in the configured catalogs. Kiln fits the family's short English infrastructure names and denotes turning source into a durable artifact. Other unrelated tools use the name; this is not global exclusivity, trademark clearance, domain registration or a catalog reservation.

## Reference snapshots

| Repository | main SHA inspected | Adopted pattern |
| --- | --- | --- |
| [Rivet](https://github.com/turlamai/rivet) | `9a951de7cc5233c3904796c51f576e969b47f142` | MIT infrastructure, bilingual entry, contribution/security policy, evidence before native claims |
| [Glaze](https://github.com/turlamai/glaze) | `1c1e13667ca6bcbfaf7572b5c38f076a9637077c` | Standard multi-collection package, separate docs/tests, explicit trust boundary |
| [Taskly](https://github.com/turlamai/taskly) | `b524b99925b777ff84e75637fe777d332fb27696` | Executable contract checks, pinned dependencies, three-host CI and clear maturity |

Files read include root listings, licenses, AGENTS, CONTRIBUTING, SECURITY, Glaze package metadata and Taskly CI. Rivet main had no classic branch protection at inspection; Kiln deliberately strengthens this with a required foundation check. Taskly's existing local changes were observed and left untouched. Reference repositories were read remotely without pulling or rewriting their local checkouts.

Family policies read at `turlamai/turlamai.github.io` master `b4e3d9fec4c20c152738c736b9b19de1b7b91efa`: `docs/PRODUCT-STANDARD.md`, `docs/DOCUMENTATION-LANGUAGES.md`, and `PORTFOLIO.md`. They establish evidence-led claims, bilingual user paths, canonical technical owners and infrastructure/commercial separation. The user's explicit Kiln bootstrap request authorizes this documentation foundation; it does not reopen unrelated portfolio implementation work.

## Reuse before construction

| Source | Observed fit | Decision |
| --- | --- | --- |
| [Official Racket syntax model](https://docs.racket-lang.org/reference/syntax-model.html) | Binding-aware host expansion and phase model | Reuse; validate extraction and target dependency classification |
| [Racket ctool](https://docs.racket-lang.org/raco/c-mods.html) | Embeds compiled modules with a Racket runtime | Does not establish standalone MCU native compilation |
| [Magnolisp documentation](https://docs.racket-lang.org/magnolisp/index.html) and [catalog](https://pkgs.racket-lang.org/package/magnolisp) | Experimental Racket-hosted language with C++ translation and restricted runtime | Evaluate techniques in M1; not adopted as a semantic replacement |
| [Picobit](https://github.com/stamourv/picobit) | Compact Scheme system; repository license API identifies GPL-3.0 | Research only; no source copied or dependency adopted |

Catalog and official-source searches did not establish an equivalent platform meeting the ordinary-Racket/native-C/qualification contract. This is a bounded survey, not proof no equivalent exists. M1 must compare reuse/adaptation with a new backend before substantial compiler work. This repository adopts no third-party compiler/runtime code. Earlier chat suggestions, including other VMs, are hypotheses rather than dependencies or technical evidence.
