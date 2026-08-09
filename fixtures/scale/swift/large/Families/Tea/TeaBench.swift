// Benchmark entry point for the tea family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct TeaBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = TeaCipher()
        let vectors = TeaVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
