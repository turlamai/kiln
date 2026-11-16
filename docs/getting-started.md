# Validate the foundation

**English** · [简体中文](getting-started.zh-CN.md)

Kiln has no firmware compiler or supported board yet. The first useful result is a checked architecture foundation and a local documentation manual.

## Requirements and commands

Use full Racket CS 9.3, Git and a terminal on macOS, Windows or Linux. Full Racket supplies Scribble, RackUnit and the referenced manuals. The package install may fetch standard dependencies; review the network environment before using it. No board, SDK, C compiler, signing key or account is needed to run the checks. Clone the repository into your normal code directory, enter it, then run:

```sh
racket kiln-tools/check-foundation.rkt
raco test kiln-test
raco pkg install --auto --name kiln --link "$PWD"
raco setup --check-pkg-deps --pkgs kiln
raco scribble --htmls --dest build/manual kiln-doc/kiln.scrbl
```

Expected: the checker prints success, RackUnit passes, dependency setup exits successfully and `build/manual/kiln/index.html` opens as a local manual. Read the [documentation map](README.md) for the full specifications. These results validate documentation structure and package metadata; they do not validate MCU code.

## Data, cleanup and troubleshooting

The linked package points to your checkout in Racket's user package registry. Generated manuals are in ignored `build/`; Racket may create ignored `compiled/` directories. The checks use disposable system-temp fixtures and do not upload diagnostics or contact hardware. The foundation contains no telemetry, user account, paid activation or secret store.

If `kiln` is already linked, inspect `raco pkg show kiln` before changing it; do not overwrite another checkout. After moving the checkout, remove the obsolete registration with `raco pkg remove kiln`, then link the intended path again. To clean the generated manual, remove only `build/manual` using your file manager. Removing a package registration does not delete your source checkout.

A missing Scribble/RackUnit dependency usually means a minimal Racket distribution was installed: use full CS 9.3 or install the declared dependencies through `raco pkg`. Broken-link errors identify the owning Markdown file and destination; correct both language paths where applicable and rerun the checker. Report defects through [Issues](https://github.com/turlamai/kiln/issues) with the commit and redacted output; use [Security](../SECURITY.md) for vulnerabilities. There is no published installer, auto-update mechanism, support SLA or qualified hardware release.
