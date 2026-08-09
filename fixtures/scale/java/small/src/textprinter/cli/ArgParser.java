package textprinter.cli;

import textprinter.model.RenderOptions;

public class ArgParser {
    public RenderOptions parse(String[] args) {
        RenderOptions options = new RenderOptions();
        for (String arg : args) {
            if (arg.startsWith("--align=")) {
                options.setAlign(valueOf(arg));
            } else if (arg.startsWith("--width=")) {
                options.setWidth(Integer.parseInt(valueOf(arg)));
            } else if (arg.startsWith("--frame=")) {
                options.setFrameName(valueOf(arg));
            } else if (arg.startsWith("--theme=")) {
                options.setThemeName(valueOf(arg));
            }
        }
        return options;
    }

    public String remainingText(String[] args) {
        StringBuilder sb = new StringBuilder();
        for (String arg : args) {
            if (!arg.startsWith("--")) {
                if (sb.length() > 0) {
                    sb.append(' ');
                }
                sb.append(arg);
            }
        }
        return sb.toString();
    }

    private String valueOf(String arg) {
        return arg.substring(arg.indexOf('=') + 1);
    }
}
