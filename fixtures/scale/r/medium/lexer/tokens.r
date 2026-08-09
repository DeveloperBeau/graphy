# Token model: a mutable cursor over scanned tokens.

token_new <- function(type, value) {
  list(type = type, value = value)
}

token_stream <- function(tokens) {
  stream <- new.env()
  stream$tokens <- tokens
  stream$pos <- 1L
  stream
}

stream_peek <- function(stream) {
  if (stream$pos > length(stream$tokens)) NULL else stream$tokens[[stream$pos]]
}

stream_next <- function(stream) {
  token <- stream_peek(stream)
  stream$pos <- stream$pos + 1L
  token
}
