// Benchmark entry point for the rc4 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Rc4Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Rc4Cipher()
        let vectors = Rc4Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
