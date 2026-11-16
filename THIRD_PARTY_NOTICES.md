# Third-party policy and inventory

The initial repository contains original documentation and foundation validation tooling. No third-party compiler, VM, device runtime, vendor SDK or driver source is copied or vendored.

| Dependency | Use | Source / license |
| --- | --- | --- |
| Racket CS 9.3 standard packages | Host checker, RackUnit, Scribble and package tooling | [Racket licensing](https://racket-lang.org/license.html); individual components retain their licenses |
| actions/checkout | CI source checkout | [MIT](https://github.com/actions/checkout/blob/main/LICENSE) |
| Bogdanp/setup-racket | CI host Racket installation | [MIT](https://github.com/Bogdanp/setup-racket/blob/master/LICENSE) |
| actions/upload-artifact | CI manual evidence retention | [MIT](https://github.com/actions/upload-artifact/blob/main/LICENSE) |

Workflow actions are pinned by full commit SHA; Dependabot proposes reviewed updates. This table is not a generated transitive SBOM and does not establish redistribution rights for future firmware.

Before adopting any package, compiler component, C library or SDK, record version/source/digest, license text, modifications, distribution artifact, notices and obligations. Keep host build dependencies distinct from linked device code. Generate per-release SBOMs and verify final archive contents. Picobit and Magnolisp are survey references only; no code or license grant is inferred from mentioning them. Third-party licensing review blocks adoption where unresolved.
