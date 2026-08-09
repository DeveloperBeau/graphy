// Benchmark entry point for the fnv1a32 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Fnv1a32Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Fnv1a32Cipher()
        let vectors = Fnv1a32Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
