package calc.config;

public enum AngleMode {
    RADIANS("rad"),
    DEGREES("deg");

    private final String shortName;

    AngleMode(String shortName) {
        this.shortName = shortName;
    }

    public String getShortName() {
        return shortName;
    }
}
