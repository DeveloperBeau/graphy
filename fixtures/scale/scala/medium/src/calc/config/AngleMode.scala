package calc.config

sealed trait AngleMode {
  def shortName: String
}

object AngleMode {
  case object Radians extends AngleMode {
    val shortName = "rad"
  }

  case object Degrees extends AngleMode {
    val shortName = "deg"
  }
}
