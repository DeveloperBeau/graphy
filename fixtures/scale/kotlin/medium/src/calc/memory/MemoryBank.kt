package calc.memory

class MemoryBank {
    private val slots = mutableMapOf<String, MemorySlot>()

    fun slot(name: String): MemorySlot =
        slots.getOrPut(name) { MemorySlot() }

    fun add(name: String, amount: Double) {
        val target = slot(name)
        target.store(target.recall() + amount)
    }

    fun clearAll() {
        slots.values.forEach { it.clear() }
    }

    fun occupiedCount(): Int = slots.values.count { it.isOccupied() }
}
