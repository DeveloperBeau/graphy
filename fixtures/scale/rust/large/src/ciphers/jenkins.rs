//! The jenkins family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const JENKINS_ID: &str = "jenkins";

/// Category label shown by the live reporter.
pub fn jenkins_category() -> &'static str {
    "hash"
}
