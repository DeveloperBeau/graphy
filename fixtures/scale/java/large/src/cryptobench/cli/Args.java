package cryptobench.cli;

public class Args {
    private final String filter;
    private final int iterations;
    private final String outDir;

    private Args(String filter, int iterations, String outDir) {
        this.filter = filter;
        this.iterations = iterations;
        this.outDir = outDir;
    }

    public static Args parse(String[] argv) {
        String filter = "";
        int iterations = 100;
        String outDir = "results";
        for (String arg : argv) {
            if (arg.startsWith("--only=")) filter = arg.substring(7);
            else if (arg.startsWith("--iterations=")) iterations = Integer.parseInt(arg.substring(13));
            else if (arg.startsWith("--out=")) outDir = arg.substring(6);
        }
        return new Args(filter, iterations, outDir);
    }

    public String getFilter() { return filter; }

    public int getIterations() { return iterations; }

    public String getOutDir() { return outDir; }
}
