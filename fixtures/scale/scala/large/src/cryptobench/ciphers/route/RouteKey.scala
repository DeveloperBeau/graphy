package cryptobench.ciphers.route

/** Parameters for the route cipher. */
final case class RouteKey(width: Int) {
  def rowCountFor(length: Int): Int = (length + width - 1) / width
}

object RouteKey {
  def default(): RouteKey = RouteKey(6)
}
