package cryptobench

import cryptobench.bench.BenchmarkRunner
import cryptobench.cli.Args
import cryptobench.config.Settings
import cryptobench.registry.SuiteCatalog

object Main {
  def main(argv: Array[String]): Unit = {
    val args = Args.parse(argv)
    val settings = Settings.fromArgs(args)
    val runner = new BenchmarkRunner(settings)
    val failures = runner.runAll(SuiteCatalog.allSuites(args.filter))
    sys.exit(if (failures == 0) 0 else 1)
  }
}
