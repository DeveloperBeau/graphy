package calc.memory

class MemorySlot {
    private var value = 0.0
    private var occupied = false

    fun store(newValue: Double) {
        value = newValue
        occupied = true
    }

    fun recall(): Double = if (occupied) value else 0.0

    fun clear() {
        value = 0.0
        occupied = false
    }

    fun isOccupied(): Boolean = occupied
}
