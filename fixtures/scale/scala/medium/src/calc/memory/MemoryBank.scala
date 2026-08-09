package calc.memory

import scala.collection.mutable

final class MemoryBank {
  private val slots = mutable.Map.empty[String, MemorySlot]

  def slot(name: String): MemorySlot =
    slots.getOrElseUpdate(name, new MemorySlot)

  def add(name: String, amount: Double): Unit = {
    val target = slot(name)
    target.store(target.recall + amount)
  }

  def clearAll(): Unit = slots.values.foreach(_.clear())

  def occupiedCount: Int = slots.values.count(_.isOccupied)
}
