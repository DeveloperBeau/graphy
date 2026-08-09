// Benchmark entry point for the substitution family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct SubstitutionBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = SubstitutionCipher()
        let vectors = SubstitutionVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
