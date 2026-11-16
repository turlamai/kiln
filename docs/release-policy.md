# Version, release and support policy

Status: no published release and no supported MCU/board. The local documentation package version `0.0.1` is bootstrap metadata, not an SDK release.

## Compatibility

Before 1.0, breaking changes require an ADR or explicit change note, updated tests and paired public guidance. After a public API exists, declare compatibility independently for host CLI/package API, source capability profiles, IR schema, runtime ABI, board manifests and evidence schema. Do not infer device compatibility from package version alone. A firmware manifest binds all relevant versions and digests.

## Release gates

A release candidate must pass `raco setup --check-pkg-deps`, all applicable `raco test` suites and Scribble construction. Runtime delivery additionally requires the evidence in [validation](validation.md), all release-blocking defects resolved, artifact-side leakage/forbidden-dependency checks, license review, clean builds and independently verifiable provenance. Cross-platform delivery claims need all corresponding host jobs; board claims need matching HIL.

Distribute official artifacts only through GitHub Releases. When host binaries are introduced, the planned Linux inventory is deb, rpm, AppImage, Flatpak bundle and tar.gz; each advertised form needs its own install/use evidence. macOS and Windows inventories and architectures require an explicit decision before publication. Firmware artifacts include ELF, map, configured flash image, manifest and diagnostics appropriate to the target. Do not create an empty release or tag to imply current availability.

Pin release inputs; development follows current upstreams with coherent dependency updates and focused checks. No automatic upgrade of a released firmware toolchain. Publish checksums, authentic signatures, source/dependency revisions, SBOM and retention/reproduction instructions. Signing keys stay out of CI pull requests and are separated by firmware, host distribution and entitlement trust domains. Release publication, destructive history changes and production-key operations require owner approval.

## Commercial boundary and maintenance

The core compiler, baseline runtime and SDK direction is MIT infrastructure, following Rivet/Glaze. There is no paid gate in the compiler or device runtime. Future commercial value may include qualified distributions, support and engineering tools after evidence establishes usefulness; no prices, sales, SLAs or LTS promises exist now. Any future separate component must state its license boundary before implementation. Granted MIT rights remain intact.

During foundation work, fixes target `main`; no backport line exists. A future release must identify support duration and security-update policy before claiming support. There is no functional-safety certification or warranty of fitness; product builders own their hazard analysis and qualification.
