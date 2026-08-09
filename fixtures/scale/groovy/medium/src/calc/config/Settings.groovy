package calc.config

class Settings {
    private int precisionValue = 6
    private AngleMode angleMode = AngleMode.RADIANS

    int getPrecision() {
        return precisionValue
    }

    void setPrecision(int value) {
        precisionValue = Math.min(15, Math.max(0, value))
    }

    void useDegrees() {
        angleMode = AngleMode.DEGREES
    }

    void useRadians() {
        angleMode = AngleMode.RADIANS
    }

    double toRadians(double value) {
        return angleMode == AngleMode.DEGREES ? Math.toRadians(value) : value
    }

    double fromRadians(double value) {
        return angleMode == AngleMode.DEGREES ? Math.toDegrees(value) : value
    }
}
