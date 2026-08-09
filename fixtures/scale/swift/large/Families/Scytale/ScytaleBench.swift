// Benchmark entry point for the scytale family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct ScytaleBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = ScytaleCipher()
        let vectors = ScytaleVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
