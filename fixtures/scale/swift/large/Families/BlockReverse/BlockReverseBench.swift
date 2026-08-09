// Benchmark entry point for the blockreverse family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct BlockReverseBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = BlockReverseCipher()
        let vectors = BlockReverseVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
