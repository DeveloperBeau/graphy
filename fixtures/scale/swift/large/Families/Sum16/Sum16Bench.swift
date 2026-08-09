// Benchmark entry point for the sum16 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Sum16Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Sum16Cipher()
        let vectors = Sum16Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
