class BenchTimer {
  late final Stopwatch _sw;

  void start() {
    _sw = Stopwatch()..start();
  }

  int stop() {
    _sw.stop();
    return _sw.elapsedMicroseconds;
  }

  static double toMillis(int micros) => micros / 1000.0;
}
