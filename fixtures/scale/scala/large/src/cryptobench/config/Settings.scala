package cryptobench.config

import java.nio.file.Path
import java.nio.file.Paths

import cryptobench.cli.Args

final class Settings(val iterations: Int, val outputDir: Path)

object Settings {
  def fromArgs(args: Args): Settings =
    new Settings(args.iterations, Paths.get(args.outDir))
}
