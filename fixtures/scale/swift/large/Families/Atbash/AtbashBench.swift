// Benchmark entry point for the atbash family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct AtbashBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = AtbashCipher()
        let vectors = AtbashVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
