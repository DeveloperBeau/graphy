package calc.config

final class Settings {
  private var precisionValue = 6
  private var angleMode: AngleMode = AngleMode.Radians

  def precision: Int = precisionValue

  def setPrecision(value: Int): Unit =
    precisionValue = math.max(0, math.min(15, value))

  def useDegrees(): Unit = angleMode = AngleMode.Degrees

  def useRadians(): Unit = angleMode = AngleMode.Radians

  def toRadians(value: Double): Double =
    if (angleMode == AngleMode.Degrees) math.toRadians(value) else value

  def fromRadians(value: Double): Double =
    if (angleMode == AngleMode.Degrees) math.toDegrees(value) else value
}
