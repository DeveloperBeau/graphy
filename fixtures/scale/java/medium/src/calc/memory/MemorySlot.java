package calc.memory;

public class MemorySlot {
    private double value;
    private boolean occupied;

    public void store(double value) {
        this.value = value;
        this.occupied = true;
    }

    public double recall() {
        return occupied ? value : 0.0;
    }

    public void clear() {
        value = 0.0;
        occupied = false;
    }

    public boolean isOccupied() {
        return occupied;
    }
}
