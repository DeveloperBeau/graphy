package cryptobench.config

import java.nio.file.Path
import java.nio.file.Paths

import cryptobench.cli.Args

class Settings {
    final int iterations
    final Path outputDir

    Settings(int iterations, Path outputDir) {
        this.iterations = iterations
        this.outputDir = outputDir
    }

    static Settings fromArgs(Args args) {
        return new Settings(args.iterations, Paths.get(args.outDir))
    }
}
