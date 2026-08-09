# Deterministic sample bytes for benchmark runs.

corpus_base <- "the quick brown fox jumps over the lazy dog 0123456789"

corpus_text <- function(n) {
  reps <- ceiling(n / (nchar(corpus_base) + 1))
  substr(strrep(paste0(corpus_base, " "), reps), 1, n)
}

corpus_sample <- function(n = 512) {
  utf8ToInt(corpus_text(n))
}
