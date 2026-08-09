package cryptobench.config;

import java.nio.file.Path;

import cryptobench.cli.Args;

public class Settings {
    private final int iterations;
    private final Path outputDir;

    public Settings(int iterations, Path outputDir) {
        this.iterations = iterations;
        this.outputDir = outputDir;
    }

    public static Settings fromArgs(Args args) {
        return new Settings(args.getIterations(), Path.of(args.getOutDir()));
    }

    public int getIterations() { return iterations; }

    public Path getOutputDir() { return outputDir; }
}
