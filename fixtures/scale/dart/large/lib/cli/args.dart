class Args {
  final String filter;
  final int iterations;
  final String outDir;

  Args(this.filter, this.iterations, this.outDir);

  factory Args.parse(List<String> argv) {
    var filter = '';
    var iterations = 100;
    var outDir = 'results';
    for (final arg in argv) {
      if (arg.startsWith('--only=')) {
        filter = arg.substring(7);
      } else if (arg.startsWith('--iterations=')) {
        iterations = int.parse(arg.substring(13));
      } else if (arg.startsWith('--out=')) {
        outDir = arg.substring(6);
      }
    }
    return Args(filter, iterations, outDir);
  }
}
