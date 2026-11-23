#lang scribble/manual
@title{Kiln: Architecture Foundation}
@author{TurLamAI}

Kiln is a Racket-native MCU platform in architecture foundation. No compiler,
device runtime, supported board or firmware release exists yet.

@section{Direction}
Ordinary @tt{#lang racket/base} modules use the official host expander and
standard packages. The planned pipeline checks explicit target capabilities,
verifies intermediate representations and generates C for a pinned cross-toolchain.
Unsupported semantics must be rejected rather than silently changed.
The default is @tt{racket/base} with ordinary imports. Compatibility follows
actual semantics and resource constraints; neither full base nor full
@tt{racket} coverage is a goal. The host retains the full Racket ecosystem.
M1 currently establishes contracts; experiments and implementation remain unstarted.

@section{Canonical Contracts}
The repository's
@hyperlink["https://github.com/turlamai/kiln/blob/main/docs/README.md"]{documentation map}
routes requirements, language semantics, IR, runtime and hardware boundaries,
validation, risk, ADRs and the next bounded handoff. Those English specifications
are the canonical technical owners. The
@hyperlink["https://github.com/turlamai/kiln/blob/main/README.zh-CN.md"]{Chinese entry}
and paired getting-started guide describe the same maturity and commands.

@section{Validation Boundary}
The current checks validate local documentation links, required files, ADR
structure and package construction on macOS, Windows and Linux. They do not
establish language correctness, MCU support, real-time bounds or certification.
Compiler differential tests, C checks, artifact scans, HIL and reproducible
firmware builds remain stage-gated work.

@section{License and Support}
Original repository contents are MIT licensed. Third-party dependencies retain
their own licenses. No paid edition, SLA, LTS or safety qualification is offered.
