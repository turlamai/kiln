# Evidence record contract

Revision: 0, proposed field specification, 2026-11-16. No machine-readable schema, validator or evidence-producing compiler is implemented. Review this contract before freezing an encoding. The [validation strategy](validation.md) owns which suites are required; this document owns how one claim is represented and qualified.

## Record identity and scope

One record covers one case, artifact/input identity and declared environment. Aggregate reports reference individual records rather than erasing failing, unavailable or excluded legs.

| Field group | Required content |
| --- | --- |
| Identity | Contract revision, unique record ID, suite/case ID, requirement IDs, originating issue and claim being tested |
| Source | Repository and full immutable source SHA; dirty state; dependency graph/checksums and policy revision actually read |
| Execution | Exact command/arguments, UTC start/end, host OS/architecture, Racket/toolchain/SDK versions and digests, relevant environment inputs |
| Language | Entry points/input domain, capability profile revision, semantic/IR/runtime ABI revisions when applicable |
| Target | Explicit scope `host-only`, `simulator` or `hardware`; target triple/layout and board/part/probe/clock configuration for target cases |
| Observation | Expected behavior, observed behavior, threshold plus unit/method, repeat count and result status |
| Artifacts | Role, immutable location, SHA-256 digest, byte size, retention/expiry and disclosure classification for each referenced output |
| Review | Reviewer identity and relation to author; review status/time; unresolved limitations and supporting/contradicting records |

Host-only cases explicitly mark target/ABI fields inapplicable with a reason. They must not fabricate a board identity. Source policy does not count as a capability-profile implementation. For hardware results, aggregate RAM and average timing alone are insufficient: identify memory regions, instrument setup, load, interrupt configuration and worst observed values, distinguishing measurement from a proved bound.

## Status rules

| Result | Meaning | Can satisfy a required gate? |
| --- | --- | --- |
| `pass` | Case executed against the identified inputs, all expected observations hold, required artifacts are present and evidence is valid | Only for its stated scope after required review |
| `fail` | Execution contradicts an expected result/threshold or produces invalid output | No |
| `unrun` | No execution has occurred | No |
| `blocked` | Named prerequisite or environment prevents execution | No |
| `inconclusive` | Execution occurred but evidence is missing, ambiguous, mismatched or expired | No |
| `not-applicable` | Scope excludes the case with an explicit reviewed rationale | Never substitutes for a required case |

These are evidence outcomes, distinct from the future compiler's `admitted`/`rejected`/`unresolved` compatibility decisions. A rejection test can pass by proving the correct diagnostic and the absence of a usable emitted artifact. Conversely, a host test that succeeds does not admit a program to a device.

Record execution and review separately. A successful command may be recorded before review but cannot close a reviewed gate. A sole maintainer can review foundation work while disclosing that they are also the author; M3's independent-review requirement needs an actual other qualified reviewer. Do not manufacture independence through a tool or job name.

## Integrity and completeness

Bind output artifacts to the exact source, dependency inputs and firmware digest; do not combine a result from one build with a map or trace from another. Missing mandatory fields, incompatible schema revisions, malformed units, duplicate record identities or missing/digest-mismatched outputs invalidate the evidence. A future decoder must reject unknown versions and enforce size/count/depth limits. None of these decoder checks exists yet.

An expired artifact changes evidence availability; preserve the historical observation but mark present verification inconclusive until reconstructed. CI artifacts currently retain foundation manuals for 30 days, which is not a long-term release evidence archive. Release qualification requires its own retention commitment and storage decision.

Output scans examine the actual distributable/diagnostic bundle and every output entry point, using seeded forbidden payloads and clean controls. Do not rely on source-string checks to establish absence of leaked data. Paths and logs are reviewed and redacted before public sharing; record both raw restricted artifacts and the reviewed public derivative with separate digests where required. No automatic upload of local evidence is introduced by this framework.

## M1 review examples

- **Present foundation claim:** documentation checks ran on an identified host/source SHA, with command results and CI manual artifacts. Scope is host-only; compiler/board claims remain unrun. The existing CI run is not automatically a conforming record until mapped to the reviewed schema.
- **Planned phase probe:** CAP-006 with expected host helper execution and a separately observed target dependency graph. Status is unrun today, not pass because the experiment was described.
- **Planned device rejection:** CAP-003 must observe the source diagnostic and absence of usable C/ELF outputs. A process exit code alone is insufficient.

Issue [#7](https://github.com/turlamai/kiln/issues/7) must review real and deliberately invalid record examples, choose the encoding and validate completeness/rejection behavior before this contract is called executable. Hardware/release records require the later gates in the roadmap.
