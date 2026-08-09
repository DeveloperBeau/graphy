// Benchmark entry point for the sdbm family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct SdbmBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = SdbmCipher()
        let vectors = SdbmVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
