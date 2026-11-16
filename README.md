# Kiln

**English** · [简体中文](README.zh-CN.md)

A Racket-native embedded platform being designed for dependable MCU products.

**Status: architecture foundation.** This repository contains specifications, governance and executable documentation checks. It has no MCU compiler, target runtime, supported board or firmware release. Commercial-grade delivery is the engineering goal, not a claim of current readiness.

## Direction

Use ordinary `#lang racket/base` modules, Racket's official expander, packages, RackUnit and Scribble on the development machine. Compile an explicitly supported runtime capability profile through verified intermediate representations to C and a pinned cross-toolchain. Keep a small C runtime and hardware adapters on the device. Unsupported semantics must produce diagnostics; integer overflow, evaluation order and tail calls must never silently acquire C semantics.

Racket ecosystem reuse does **not** imply that arbitrary Racket packages run on a microcontroller. Host macros and target runtime dependencies have separate compatibility and trust requirements. No new Scheme dialect or package manager is planned.

## Start here

There is nothing to flash yet. Read the [architecture](docs/architecture.md), [language contract](docs/language-contract.md) and [roadmap](docs/roadmap.md). To validate this foundation with Racket CS 9.3:

```sh
racket kiln-tools/check-foundation.rkt
raco test kiln-test
raco pkg install --auto --name kiln --link "$PWD"
raco setup --check-pkg-deps --pkgs kiln
raco scribble --htmls --dest build/manual kiln-doc/kiln.scrbl
```

The local package is documentation-only and is not published to the catalog. The check commands do not test MCU behavior. See [getting started and recovery](docs/getting-started.md) for prerequisites, output locations and cleanup.

## Scope and limits

| Area | Current evidence | Planned gate |
| --- | --- | --- |
| Host tooling | Foundation CI on macOS, Windows and Linux | Reproduce the same target image across hosts |
| Language | Proposed capability and rejection rules | Differential tests against pinned desktop Racket |
| Native output | C is the selected initial backend | Verified IR, C semantics and ELF artifact checks |
| Hardware | No qualified targets | One Cortex-M reference board, then a real product |
| Real time | No timing guarantee | Board-specific stack, interrupt and timing evidence |
| Commercial use | MIT source rights | Separate qualified distribution/support decisions |

RISC-V, RTOS adapters, a VM and industry-specific integrations are later evaluation topics. Kiln is professional infrastructure; mobile application hosts are outside its scope. Future graphical tools must use the family's Rivet or Glaze path and prototype-first workflow; neither framework is a device runtime dependency.

## Contribute and report

Use [Issues](https://github.com/turlamai/kiln/issues) for proposals and defects, [Contributing](CONTRIBUTING.md) for checks, and [Security](SECURITY.md) for private vulnerability reporting. Share only redacted, deliberately reviewed diagnostics. Nothing is automatically uploaded by the foundation tooling.

The [documentation map](docs/README.md) routes requirements, ADRs, validation, risks, governance and the next implementation handoff. Normative technical specifications are English; this README and the getting-started guide provide complete Chinese counterparts.

[MIT](LICENSE). Third-party licenses remain independent; see [third-party policy](THIRD_PARTY_NOTICES.md). No paid edition, support SLA or certification is currently offered.
