package calc.config

enum class AngleMode(val shortName: String) {
    RADIANS("rad"),
    DEGREES("deg");

    fun describe(): String = name.lowercase() + " (" + shortName + ")"

    fun other(): AngleMode = if (this == RADIANS) DEGREES else RADIANS
}
