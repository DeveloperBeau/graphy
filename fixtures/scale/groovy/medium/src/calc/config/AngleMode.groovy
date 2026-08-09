package calc.config

enum AngleMode {
    RADIANS("rad"),
    DEGREES("deg")

    final String shortName

    AngleMode(String shortName) {
        this.shortName = shortName
    }
}
