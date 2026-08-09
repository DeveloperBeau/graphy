package calc.io

class Banner {
    private static final String VERSION = "2.1.0"

    static String render() {
        StringBuilder sb = new StringBuilder()
        sb.append("mathwork ").append(VERSION).append('\n')
        sb.append("type an expression, :help for commands, :quit to exit")
        return sb.toString()
    }
}
