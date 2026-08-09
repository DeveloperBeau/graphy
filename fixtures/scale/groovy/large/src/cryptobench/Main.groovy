package cryptobench

import cryptobench.bench.BenchmarkRunner
import cryptobench.cli.Args
import cryptobench.config.Settings
import cryptobench.registry.SuiteCatalog

class Main {
    static void main(String[] argv) {
        Args args = Args.parse(argv)
        Settings settings = Settings.fromArgs(args)
        BenchmarkRunner runner = new BenchmarkRunner(settings)
        int failures = runner.runAll(SuiteCatalog.allSuites(args.filter))
        System.exit(failures == 0 ? 0 : 1)
    }
}
