package calc.util;

public class DoubleCompare {
    public static final double EPSILON = 1e-12;

    public static boolean nearlyZero(double value) {
        return Math.abs(value) < EPSILON;
    }

    public static boolean nearlyEqual(double a, double b) {
        return Math.abs(a - b) < EPSILON * Math.max(1.0, Math.max(Math.abs(a), Math.abs(b)));
    }
}
