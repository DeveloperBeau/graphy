// Benchmark entry point for the xorrolling family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct XorRollingBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = XorRollingCipher()
        let vectors = XorRollingVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
