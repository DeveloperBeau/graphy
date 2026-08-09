// Benchmark entry point for the rot13 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Rot13Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Rot13Cipher()
        let vectors = Rot13Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
