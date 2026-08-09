// Benchmark entry point for the polybius family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct PolybiusBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = PolybiusCipher()
        let vectors = PolybiusVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
