# Intermediate representation contract

Status: proposed design envelope. No serialized schema or public IR API is frozen.

## Three boundaries

1. **Semantic IR** records resolved binding IDs, module/phase identity, ordered evaluation, explicit value arity, tail position, source origin and primitive semantic identity. It is independent of C types and board addresses.
2. **Resource IR** adds types/ranges, data layout, ownership/lifetimes, allocation effects, call graph, stack obligations, interrupt context and fault edges. Unknown facts are represented explicitly, never as zero costs.
3. **C representation** makes temporaries, sequencing, calling convention, checked conversions, sections and runtime calls explicit before rendering text. Generated C is an inspectable artifact, not the semantic source of truth.

## Verifier obligations

Every stage checks unique/resolved identifiers, scope and dominance, type/arity consistency, legal control-flow targets, use-before-initialization, reachable terminators, effect preservation and source provenance. Resource lowering additionally checks no escaping stack references, no illegal ISR calls, no unbounded required stack fact, and no hidden allocation under a no-allocation profile. C lowering checks representable constants, explicit evaluation sequencing and ABI agreement.

Each pass declares accepted IR version, preserved facts, invalidated analyses and required revalidation. An optimization must not retain stale range or alias facts after changing the graph. Version mismatch or malformed IR is an error before emitting usable output. Persisted IR is untrusted input with bounded lengths, recursion limits and reject-by-default unknown tags.

## Semantics and test strategy

Do not freeze SSA, binary encoding or a universal type system before experiments establish need. A small internal reference evaluator is a candidate oracle for the pure semantic IR, paired with desktop Racket. Property tests compare pre/post-pass observations; malformed fixtures prove verifier rejection. C differential tests include side effects, integer boundaries, tail recursion and fault results. Retain minimized counterexamples as regression inputs.

Debug locations survive inlining, desugaring and optimization as origin chains. Deterministic IDs derive from normalized build inputs, not hash iteration order or machine paths. Any serialization proposal must specify schema version, canonical ordering, explicit target layout and resource limits, with golden and hostile-input vectors before adoption.
