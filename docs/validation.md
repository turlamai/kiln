# Validation and evidence contract

Status: foundation checks are executable; compiler, target and release suites are planned.

## Evidence ladder

| Stage | Required checks | What it does not prove |
| --- | --- | --- |
| Foundation (now) | Required docs, Markdown file links/anchors, ADR structure, bilingual entry links, checker red/green tests, package dependency checks and Scribble build on three OSes | Language or hardware behavior |
| Frontend | Positive/negative source corpus, binding/phase graph, macro origins, diagnostics and dependency isolation | Correct generated code |
| Compiler | Unit/property/metamorphic tests, pass verification, malformed IR, desktop differential oracle, C sanitizer/optimization matrix | Device timing |
| Target | Same corpus on simulator and board, memory maps, stack, interrupt tests, faults, debug mapping and power/reset recovery | Other boards or certification |
| Product | Workload/C baseline comparison, deadline/resource thresholds, soak and update recovery | Unmeasured usage domains |
| Release | Reproducibility, final-output scan, SBOM/licenses, signed provenance and clean install/use | LTS or audit claims without an explicit program |

## Differential corpus

For every admitted feature include ordinary, boundary and interaction cases. Evaluate supported inputs under a pinned desktop Racket and compare structured observations with semantic IR, host-generated C and device runs. Compare values, mutation order, initialization and faults, not just process exit. Record seeds and minimized failures. Prevent tests from sharing the same faulty lowering code as their oracle. Explicit device-width APIs need an independent mathematical oracle for their documented semantics.

The rejection corpus covers unsupported operations hidden in macros, imported initializers, indirect calls, phase shifts, escaping closures, arithmetic beyond the proved domain and ISR transitive effects. A negative test must assert the diagnostic and absence of a usable emitted artifact. Mutation checks should demonstrate that disabling a relevant safety check makes the suite fail.

## Output-side gates

For every firmware and distributable entry point scan the actual generated C, preprocessed inputs where needed, linker map, ELF sections/symbols, debug data, archives, SBOM and diagnostic bundle. Detect forbidden runtime/allocator dependencies, exceeded memory regions, local paths, secrets and private identifiers. Include seeded forbidden payloads and clean controls: source-only pattern matching is insufficient. Tool invocations and manifest parsing fail closed on missing output. Thresholds are versioned product inputs; tests cannot weaken them merely to pass CI.

## Reproducibility and HIL

Pin Racket, package checksums, C toolchain, SDK, flags, environment and board manifest. Normalize timestamps and paths explicitly, compare independent clean builds, retain raw digests, and investigate mismatches before claiming reproducibility. macOS, Windows and Linux are equal development hosts; early foundation CI is not evidence of a cross-host firmware build.

HIL jobs use protected runners, reviewed commits and exclusive board leases. Untrusted pull requests cannot flash hardware or access signing keys. Record board/probe identifiers and calibration/configuration; serial capture, firmware digest and clock setup must match the job. Hardware absence, timeout, skipped and queued results are **unverified**, never passes. Start with host/simulator evidence, then add real-device proof.

## Evidence record and traceability

Every acceptance record identifies requirement ID, test case, source SHA, dependency/tool pins, profile, target/board revision, OS/architecture, command, CI run URL, artifact SHA-256, observed result, threshold, timestamp and reviewer. Product evidence additionally includes hardware setup and repeat count. Store large artifacts in CI/release storage with retention stated by the release; link immutable artifacts from the issue. A changed contract requires the same review as changed behavior. M1 defines the machine-readable schema before runtime claims are admitted.

## Current commands

Use the [getting-started commands](getting-started.md). The foundation checker is deliberately limited: it validates repository document structure and local links, not prose correctness, translation equivalence, external URL availability or full Markdown syntax. Human review remains required. Its regression tests use disposable directories and never mutate repository files.
