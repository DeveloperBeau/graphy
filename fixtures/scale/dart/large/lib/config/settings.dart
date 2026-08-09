import '../cli/args.dart';

class Settings {
  final int iterations;
  final String outputDir;

  Settings(this.iterations, this.outputDir);

  factory Settings.fromArgs(Args args) => Settings(args.iterations, args.outDir);
}
