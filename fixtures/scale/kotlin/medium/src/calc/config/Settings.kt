package calc.config

class Settings {
    var precision: Int = 6
        set(value) {
            field = value.coerceIn(0, 15)
        }
    private var angleMode = AngleMode.RADIANS

    fun useDegrees() {
        angleMode = AngleMode.DEGREES
    }

    fun useRadians() {
        angleMode = AngleMode.RADIANS
    }

    fun toRadians(value: Double): Double =
        if (angleMode == AngleMode.DEGREES) Math.toRadians(value) else value

    fun fromRadians(value: Double): Double =
        if (angleMode == AngleMode.DEGREES) Math.toDegrees(value) else value
}
