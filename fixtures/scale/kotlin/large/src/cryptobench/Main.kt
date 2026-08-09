package cryptobench

import cryptobench.bench.BenchmarkRunner
import cryptobench.cli.Args
import cryptobench.config.Settings
import cryptobench.registry.SuiteCatalog
import kotlin.system.exitProcess

fun main(argv: Array<String>) {
    val args = Args.parse(argv)
    val settings = Settings.fromArgs(args)
    val runner = BenchmarkRunner(settings)
    val failures = runner.runAll(SuiteCatalog.allSuites(args.filter))
    exitProcess(if (failures == 0) 0 else 1)
}
