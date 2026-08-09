// Benchmark entry point for the trithemius family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct TrithemiusBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = TrithemiusCipher()
        let vectors = TrithemiusVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
