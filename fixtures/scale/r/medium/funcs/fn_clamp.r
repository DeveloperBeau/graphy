# Clamp a value into [low, high].

calc_clamp <- function(x, low, high) {
  stopifnot(low <= high)
  if (x < low) {
    return(low)
  }
  if (x > high) {
    return(high)
  }
  x
}
