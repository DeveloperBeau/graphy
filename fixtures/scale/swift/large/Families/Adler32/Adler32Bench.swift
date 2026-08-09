// Benchmark entry point for the adler32 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Adler32Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Adler32Cipher()
        let vectors = Adler32Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
