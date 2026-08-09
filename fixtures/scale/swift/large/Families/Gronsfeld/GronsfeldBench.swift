// Benchmark entry point for the gronsfeld family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct GronsfeldBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = GronsfeldCipher()
        let vectors = GronsfeldVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
