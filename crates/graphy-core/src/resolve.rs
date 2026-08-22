//! Project-wide, language-agnostic call resolution ("Layer 1").
//!
//! Every extractor already resolves a call locally when it can (the callee is
//! declared in the same file). When it can't, `crate::extract::common::emit_call`
//! records the call as a sentinel edge instead of dropping it. This module
//! indexes every definition in the corpus and retargets or removes those
//! sentinels after extraction, so a call to a symbol declared in another file
//! resolves without any per-language receiver typing.

/// Relation on an edge that records a call the extractor could not resolve
/// inside one file. Never reaches the graph: `CallIndex::resolve_in` either
/// retargets it at a real definition or removes it.
pub const UNRESOLVED_CALL: &str = "calls?unresolved";
/// Prefix on the target id of an [`UNRESOLVED_CALL`] edge; the remainder is the
/// callee text exactly as the extractor read it out of the source.
pub const UNRESOLVED_PREFIX: &str = "unresolved::";
