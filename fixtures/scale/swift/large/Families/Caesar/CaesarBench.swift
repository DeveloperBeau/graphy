// Benchmark entry point for the caesar family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct CaesarBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = CaesarCipher()
        let vectors = CaesarVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
