// Benchmark entry point for the keyword family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct KeywordBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = KeywordCipher()
        let vectors = KeywordVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
