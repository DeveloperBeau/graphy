// Benchmark entry point for the nibbleswap family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct NibbleSwapBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = NibbleSwapCipher()
        let vectors = NibbleSwapVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
