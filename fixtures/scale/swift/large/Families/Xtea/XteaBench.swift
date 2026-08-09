// Benchmark entry point for the xtea family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct XteaBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = XteaCipher()
        let vectors = XteaVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
