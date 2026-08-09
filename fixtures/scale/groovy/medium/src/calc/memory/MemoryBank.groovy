package calc.memory

class MemoryBank {
    private final Map<String, MemorySlot> slots = [:]

    MemorySlot slot(String name) {
        return slots.computeIfAbsent(name) { new MemorySlot() }
    }

    void add(String name, double amount) {
        MemorySlot target = slot(name)
        target.store(target.recall() + amount)
    }

    void clearAll() {
        slots.values().each { it.clear() }
    }

    int occupiedCount() {
        return slots.values().count { it.isOccupied() }
    }
}
