package cryptobench.config

import cryptobench.cli.Args
import java.nio.file.Path

class Settings(
    val iterations: Int,
    val outputDir: Path,
) {
    companion object {
        fun fromArgs(args: Args): Settings =
            Settings(args.iterations, Path.of(args.outDir))
    }
}
