// Benchmark entry point for the lcgstream family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct LcgStreamBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = LcgStreamCipher()
        let vectors = LcgStreamVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
