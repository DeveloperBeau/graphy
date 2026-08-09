package calc.util

class DoubleCompare {
    static final double EPSILON = 1e-12

    static boolean nearlyZero(double value) {
        return Math.abs(value) < EPSILON
    }

    static boolean nearlyEqual(double a, double b) {
        return Math.abs(a - b) < EPSILON * Math.max(1.0, Math.max(Math.abs(a), Math.abs(b)))
    }
}
