package calc.memory

final class MemorySlot {
  private var value = 0.0
  private var occupied = false

  def store(newValue: Double): Unit = {
    value = newValue
    occupied = true
  }

  def recall: Double = if (occupied) value else 0.0

  def clear(): Unit = {
    value = 0.0
    occupied = false
  }

  def isOccupied: Boolean = occupied
}
