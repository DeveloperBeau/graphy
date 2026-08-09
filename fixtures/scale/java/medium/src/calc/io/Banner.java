package calc.io;

public class Banner {
    private static final String VERSION = "1.4.2";

    public static String render() {
        StringBuilder sb = new StringBuilder();
        sb.append("mathwork ").append(VERSION).append('\n');
        sb.append("type an expression, :help for commands, :quit to exit");
        return sb.toString();
    }
}
