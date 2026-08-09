pub mod progress;
pub mod reporter;
pub mod summary;

pub use progress::ProgressBar;
pub use summary::Summary;

/// Width of the rendered progress bar in characters.
pub const BAR_WIDTH: usize = 32;

pub fn separator() -> String {
    "-".repeat(BAR_WIDTH + 8)
}
