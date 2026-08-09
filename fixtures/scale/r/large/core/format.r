# Human-readable units.

fmt_bytes <- function(n) {
  if (n >= 1048576) {
    sprintf("%dMiB", n %/% 1048576)
  } else if (n >= 1024) {
    sprintf("%dKiB", n %/% 1024)
  } else {
    sprintf("%dB", n)
  }
}

fmt_micros <- function(us) {
  if (us >= 1e6) sprintf("%ds", us %/% 1e6) else sprintf("%dus", us)
}
