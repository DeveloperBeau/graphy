pub mod bytes;
pub mod errors;
pub mod hex;
pub mod rng;
pub mod sample;
pub mod stats;
pub mod textenc;
pub mod timer;

/// Name reported in the summary footer.
pub const TOOL_NAME: &str = "cipherbench";

pub fn version_line() -> String {
    format!("{} {}", TOOL_NAME, env!("CARGO_PKG_VERSION"))
}
