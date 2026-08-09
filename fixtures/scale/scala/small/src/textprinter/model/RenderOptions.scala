package textprinter.model

final case class RenderOptions(
    align: String = "left",
    width: Int = 60,
    frameName: String = "ascii",
    themeName: String = "plain"
) {
  /** Clamp anything the flag parser let through to sane bounds. */
  def normalized: RenderOptions =
    copy(width = math.max(8, math.min(200, width)))
}
