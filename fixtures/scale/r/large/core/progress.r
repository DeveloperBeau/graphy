# Single-line live progress display.

.bench_progress <- new.env()
.bench_progress$total <- 0L
.bench_progress$done <- 0L

progress_start <- function(total) {
  .bench_progress$total <- total
  .bench_progress$done <- 0L
}

progress_tick <- function(label) {
  .bench_progress$done <- .bench_progress$done + 1L
  cat(sprintf("\r[%d/%d] %s", .bench_progress$done, .bench_progress$total, label))
}

progress_done <- function() {
  cat("\r", strrep(" ", 60), "\r", sep = "")
}
