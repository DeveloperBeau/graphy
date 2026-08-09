package cryptobench;

import cryptobench.bench.BenchmarkRunner;
import cryptobench.cli.Args;
import cryptobench.config.Settings;
import cryptobench.registry.SuiteCatalog;

public class Main {
    public static void main(String[] argv) {
        Args args = Args.parse(argv);
        Settings settings = Settings.fromArgs(args);
        BenchmarkRunner runner = new BenchmarkRunner(settings);
        int failures = runner.runAll(SuiteCatalog.allSuites(args.getFilter()));
        System.exit(failures == 0 ? 0 : 1);
    }
}
