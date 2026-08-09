// Benchmark entry point for the railfence family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct RailfenceBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = RailfenceCipher()
        let vectors = RailfenceVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
