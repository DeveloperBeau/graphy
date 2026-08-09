package calc.memory

class MemorySlot {
    private double value = 0.0
    private boolean occupied = false

    void store(double newValue) {
        value = newValue
        occupied = true
    }

    double recall() {
        return occupied ? value : 0.0
    }

    void clear() {
        value = 0.0
        occupied = false
    }

    boolean isOccupied() {
        return occupied
    }
}
