// Benchmark entry point for the djb2 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Djb2Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Djb2Cipher()
        let vectors = Djb2Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
