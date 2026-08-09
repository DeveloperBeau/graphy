package textprinter.border

object Frames {
  def ascii: Frame = Frame('+', '-', '|')

  def rounded: Frame = Frame('o', '─', '│')

  def doubled: Frame = Frame('╔', '═', '║')

  def byName(name: String): Frame = name match {
    case "rounded" => rounded
    case "double"  => doubled
    case _         => ascii
  }
}
