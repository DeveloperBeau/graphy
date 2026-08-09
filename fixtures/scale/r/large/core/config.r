# Bench tuning knobs with environment overrides.

bench_env <- function(name, fallback) {
  value <- Sys.getenv(name, unset = "")
  if (nzchar(value)) value else fallback
}

config_get <- function(name) {
  switch(name,
    warmup = as.integer(bench_env("CIPHBENCH_WARMUP", "2")),
    verbose = identical(bench_env("CIPHBENCH_VERBOSE", "0"), "1"),
    stop(sprintf("unknown setting: %s", name))
  )
}
