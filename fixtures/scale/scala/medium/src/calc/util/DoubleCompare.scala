package calc.util

object DoubleCompare {
  val Epsilon = 1e-12

  def nearlyZero(value: Double): Boolean = math.abs(value) < Epsilon

  def nearlyEqual(a: Double, b: Double): Boolean =
    math.abs(a - b) < Epsilon * math.max(1.0, math.max(math.abs(a), math.abs(b)))
}
