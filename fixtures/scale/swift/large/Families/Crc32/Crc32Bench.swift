// Benchmark entry point for the crc32 family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct Crc32Bench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = Crc32Cipher()
        let vectors = Crc32Vectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
