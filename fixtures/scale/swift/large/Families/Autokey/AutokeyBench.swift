// Benchmark entry point for the autokey family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct AutokeyBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = AutokeyCipher()
        let vectors = AutokeyVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
