// Benchmark entry point for the xorstatic family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct XorStaticBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = XorStaticCipher()
        let vectors = XorStaticVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
