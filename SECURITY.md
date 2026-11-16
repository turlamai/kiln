# Security policy

Kiln is an unaudited architecture foundation, with no released compiler, runtime or supported hardware. Fixes target main only; no supported release or backport line exists.

Report suspected vulnerabilities through [GitHub private vulnerability reporting](https://github.com/turlamai/kiln/security/advisories/new). Do not open a public issue with exploitable details, secrets, proprietary source, customer data or device keys. Include the affected commit, host/target context, minimal redacted reproduction and expected impact. Coordinate disclosure with the maintainer; no response SLA is offered.

## Trust boundaries

- Racket reading/expansion and package hooks can execute host code. Treat source and dependencies as executable inputs, isolate untrusted builds at the OS boundary, and keep secrets off those workers.
- Future IR/manifests, driver metadata and diagnostics are untrusted structured input. Enforce sizes, versions and fail-closed decoding.
- C drivers, BSPs, toolchains and flashing tools are privileged components needing pinned provenance and review. A green host test does not qualify them for physical hardware.
- HIL runners and signing jobs must never execute unreviewed pull-request code with hardware or key access. Firmware keys, host release keys and product entitlement keys remain separate.
- Foundation checks inspect local files and create disposable test fixtures. They do not intentionally upload data or invoke devices. Racket dependency installation can access package sources.

Firmware safe state, secure boot, update rollback and physical threats belong to the product qualification. Kiln supplies no safety/security certification. See [validation](docs/validation.md) for planned output-side leakage and artifact gates; those device gates are not implemented yet.
