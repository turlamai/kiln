# ADR 0004: MIT infrastructure and evidence-led delivery

Status: Accepted

Date: 2026-11-16

## Context

The family separates reusable infrastructure from product commerce. A new compiler platform needs commercial engineering discipline without implying shipped capabilities or introducing device licensing dependencies.

## Decision

License this original foundation and the intended core compiler/runtime/SDK under MIT, matching Rivet/Glaze infrastructure. Keep product entitlements and payments outside the compiler/device runtime. Establish bilingual entry paths, canonical English technical contracts, stage gates, protected main and evidence-based acceptance.

## Alternatives

Copying a desktop product license or inventing paid compiler gates would conflate infrastructure with product policy. Unprotected documentation bootstrap would leave later agents without enforceable checks.

## Consequences

Third-party code and SDKs need independent license review. Any future separately licensed tool or support offer needs an explicit boundary and owner decision. No present SLA, certification, paid edition or qualified target follows from this ADR.
