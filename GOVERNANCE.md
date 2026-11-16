# Governance

Kiln is maintained by [@turlamai](https://github.com/turlamai). The maintainer owns architecture acceptance, issue triage, security coordination and releases. There is no implied steering committee or independent reviewer today.

## Decision process

Open an issue with an observable outcome, affected requirement/contract, evidence plan and risks. Durable architectural changes add or supersede an ADR. ADR statuses are Proposed, Accepted, Rejected or Superseded. An accepted direction is not an implemented capability. Changes to semantics, runtime ABI, interrupt behavior, evidence gates or licenses receive explicit maintainer review. An author cannot claim independent review of their own work.

## Main and integration

Require the aggregate `Foundation gate` before integrating ongoing changes, with branch up-to-date checks. Disable force pushes and deletion of main. Bootstrap is the sole initial direct push before checks/protection exist. Protection covers administrators; a zero mandatory review count preserves a usable sole-maintainer workflow while PRs still expose the decision and evidence. Reassess independent review requirements before M3.

Use issues/milestones for the cross-device queue. Each issue states dependencies, acceptance criteria, owned contracts, evidence and explicit non-goals. Close a milestone only when all exit criteria are met; unrun hardware checks block closure. Use squash merges for coherent slices and delete merged short-lived branches after checking no other work depends on them.

## Releases and conduct

Release publication and destructive remote actions need owner approval. No support/security response time is promised. Follow [release policy](docs/release-policy.md) and [Security](SECURITY.md). Be respectful, discuss evidence rather than people, and avoid harassment or disclosure of private information. The maintainer may moderate conduct, explain a decision and accept a private appeal through GitHub contact channels.
