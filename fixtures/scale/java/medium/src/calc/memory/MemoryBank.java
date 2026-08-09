package calc.memory;

import java.util.HashMap;
import java.util.Map;

public class MemoryBank {
    private final Map<String, MemorySlot> slots = new HashMap<>();

    public MemorySlot slot(String name) {
        return slots.computeIfAbsent(name, key -> new MemorySlot());
    }

    public void add(String name, double amount) {
        MemorySlot target = slot(name);
        target.store(target.recall() + amount);
    }

    public void clearAll() {
        slots.values().forEach(MemorySlot::clear);
    }

    public int occupiedCount() {
        return (int) slots.values().stream().filter(MemorySlot::isOccupied).count();
    }
}
