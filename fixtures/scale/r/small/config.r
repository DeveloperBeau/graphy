# Runtime defaults, overridable via TEXTPRINT_* environment variables.

tp_default <- function(envvar, fallback) {
  value <- Sys.getenv(envvar, unset = "")
  if (nzchar(value)) value else fallback
}

config_get <- function(name) {
  switch(name,
    width = as.integer(tp_default("TEXTPRINT_WIDTH", "72")),
    style = tp_default("TEXTPRINT_STYLE", "plain"),
    color = tp_default("TEXTPRINT_COLOR", "auto"),
    stop(sprintf("unknown setting: %s", name))
  )
}

config_use_color <- function() {
  config_get("color") != "never"
}
