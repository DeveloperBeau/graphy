package textprinter.style

final case class Theme(name: String, textColor: Int, emphasize: Boolean) {

  def apply(text: String): String = {
    val colored = if (textColor == 0) text else Styles.colorize(text, textColor)
    if (emphasize) Styles.bold(colored) else colored
  }
}

object Theme {
  def named(name: String): Theme = name match {
    case "ocean"  => Theme(name, 36, emphasize = false)
    case "alert"  => Theme(name, 31, emphasize = true)
    case "forest" => Theme(name, 32, emphasize = false)
    case _        => Theme("plain", 0, emphasize = false)
  }
}
