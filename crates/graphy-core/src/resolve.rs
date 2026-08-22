//! Project-wide, language-agnostic call resolution ("Layer 1").
//!
//! Every extractor already resolves a call locally when it can (the callee is
//! declared in the same file). When it can't, `crate::extract::common::emit_call`
//! records the call as a sentinel edge instead of dropping it. This module
//! indexes every definition in the corpus and retargets or removes those
//! sentinels after extraction, so a call to a symbol declared in another file
//! resolves without any per-language receiver typing.

use std::collections::{HashMap, HashSet};

use crate::schema::{Confidence, ExtractionOutput};

/// Relation on an edge that records a call the extractor could not resolve
/// inside one file. Never reaches the graph: `CallIndex::resolve_in` either
/// retargets it at a real definition or removes it.
pub const UNRESOLVED_CALL: &str = "calls?unresolved";
/// Prefix on the target id of an [`UNRESOLVED_CALL`] edge; the remainder is the
/// callee text exactly as the extractor read it out of the source.
pub const UNRESOLVED_PREFIX: &str = "unresolved::";

#[derive(Debug, Default, Clone, Copy, PartialEq, Eq)]
pub struct ResolveStats {
    /// Unresolved-call edges retargeted at a real definition.
    pub resolved: usize,
    /// Unresolved-call edges removed because nothing unique matched.
    pub dropped: usize,
}

struct Candidate {
    id: String,
    source_file: Option<String>,
    is_test: bool,
}

/// Kinds that can be the target of a call. A positive gate, not a denylist:
/// the motivating corpus carries thousands of `json_key?ambiguous` nodes, and
/// a Markdown heading or a CSS selector whose text happens to match an
/// identifier must never become a callee.
const CODE_KINDS: &[&str] = &[
    "function",
    "method",
    "class",
    "struct",
    "enum",
    "interface",
    "protocol",
    "trait",
    "record",
    "object",
    "module",
    "namespace",
    "macro",
    "sub",
    "subroutine",
    "mod",
    "package",
    "unit",
    "extension",
    "mixin",
];

fn is_code_kind(kind: Option<&str>) -> bool {
    let Some(k) = kind else { return false };
    CODE_KINDS.contains(&k.split('?').next().unwrap_or(k))
}

/// Path-shaped test detection. Lowercased, component-wise.
/// ponytail: `latest.py` reads as a test file and its definitions get skipped
/// for non-test callers — a missing inferred edge, never a wrong one. Tighten
/// with a real test-layout config only if someone complains.
fn is_test_path(path: &str) -> bool {
    let lower = path.to_lowercase();
    let components: Vec<&str> = lower.split(['/', '\\']).collect();
    if components
        .iter()
        .any(|c| matches!(*c, "test" | "tests" | "spec" | "specs" | "__tests__"))
    {
        return true;
    }
    let Some(file_name) = components.last() else {
        return false;
    };
    let stem = file_name.rsplit_once('.').map_or(*file_name, |(s, _)| s);
    stem.starts_with("test_")
        || stem.starts_with("spec_")
        || stem.ends_with("test")
        || stem.ends_with("_test")
        || stem.ends_with(".test")
        || stem.ends_with("spec")
        || stem.ends_with("_spec")
        || stem.ends_with(".spec")
}

/// Project-wide index of definitions that a call may resolve to.
pub struct CallIndex {
    by_label: HashMap<String, Vec<Candidate>>,
}

impl CallIndex {
    /// Build the index from every extraction in the corpus. Must be called
    /// after any dedup map has been applied, or the index will contain ids
    /// that no longer exist.
    pub fn build<'a>(outs: impl IntoIterator<Item = &'a ExtractionOutput>) -> Self {
        let mut by_label: HashMap<String, Vec<Candidate>> = HashMap::new();
        for out in outs {
            for n in &out.nodes {
                if !n.id.starts_with("extern::")
                    && is_code_kind(n.kind.as_deref())
                    && !n.label.is_empty()
                {
                    let is_test = n.source_file.as_deref().map(is_test_path).unwrap_or(false);
                    by_label
                        .entry(n.label.clone())
                        .or_default()
                        .push(Candidate {
                            id: n.id.clone(),
                            source_file: n.source_file.clone(),
                            is_test,
                        });
                }
            }
        }
        Self { by_label }
    }

    fn is_identifier(text: &str) -> bool {
        if text.is_empty() {
            return false;
        }
        let mut chars = text.chars();
        let first = chars.next().unwrap();
        if first.is_ascii_digit() {
            return false;
        }
        text.chars()
            .all(|c| c.is_alphanumeric() || c == '_' || c == '$')
    }

    fn lookup(&self, text: &str, caller_is_test: bool) -> Option<String> {
        let text = text.trim();
        if text.is_empty() {
            return None;
        }
        let mut cands: Vec<&Candidate> = if !text.contains(['.', ':', '>', '/', '(', ' ']) {
            if !Self::is_identifier(text) {
                return None;
            }
            self.by_label.get(text)?.iter().collect()
        } else {
            let head = text.split(['.', ':']).next()?;
            let leaf = text.rsplit(['.', ':', '>', ' ']).next()?;
            if matches!(head, "self" | "this" | "cls" | "super") {
                return None;
            }
            if !Self::is_identifier(head) || !Self::is_identifier(leaf) {
                return None;
            }
            let head_cands = self.by_label.get(head)?;
            if head_cands.len() != 1 {
                return None;
            }
            let head_file = head_cands[0].source_file.as_deref()?;
            self.by_label
                .get(leaf)?
                .iter()
                .filter(|c| c.source_file.as_deref() == Some(head_file))
                .collect()
        };
        if !caller_is_test {
            cands.retain(|c| !c.is_test);
        }
        if cands.len() != 1 {
            return None;
        }
        Some(cands[0].id.clone())
    }

    /// Retarget or remove every `UNRESOLVED_CALL` edge in one extraction.
    /// After this returns, `out` contains no `UNRESOLVED_CALL` edge.
    pub fn resolve_in(&self, out: &mut ExtractionOutput) -> ResolveStats {
        let mut existing: HashSet<(String, String)> = out
            .edges
            .iter()
            .filter(|e| e.relation == "calls")
            .map(|e| (e.source.clone(), e.target.clone()))
            .collect();
        let mut stats = ResolveStats::default();
        out.edges.retain_mut(|e| {
            if e.relation != UNRESOLVED_CALL {
                return true;
            }
            let callee_text = e
                .target
                .strip_prefix(UNRESOLVED_PREFIX)
                .unwrap_or(&e.target);
            let caller_is_test = is_test_path(&e.source);
            match self.lookup(callee_text, caller_is_test) {
                Some(id) if !existing.contains(&(e.source.clone(), id.clone())) => {
                    existing.insert((e.source.clone(), id.clone()));
                    e.target = id;
                    e.relation = "calls".to_string();
                    e.confidence = Confidence::Inferred;
                    stats.resolved += 1;
                    true
                }
                _ => {
                    stats.dropped += 1;
                    false
                }
            }
        });
        stats
    }
}
