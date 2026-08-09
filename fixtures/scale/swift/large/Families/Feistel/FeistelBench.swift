// Benchmark entry point for the feistel family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct FeistelBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = FeistelCipher()
        let vectors = FeistelVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
