package calc.config;

public class Settings {
    private int precision = 6;
    private AngleMode angleMode = AngleMode.RADIANS;

    public int getPrecision() {
        return precision;
    }

    public void setPrecision(int precision) {
        this.precision = Math.min(15, Math.max(0, precision));
    }

    public void useDegrees() {
        angleMode = AngleMode.DEGREES;
    }

    public void useRadians() {
        angleMode = AngleMode.RADIANS;
    }

    public double toRadians(double value) {
        return angleMode == AngleMode.DEGREES ? Math.toRadians(value) : value;
    }

    public double fromRadians(double value) {
        return angleMode == AngleMode.DEGREES ? Math.toDegrees(value) : value;
    }
}
