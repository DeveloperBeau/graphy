// Benchmark entry point for the affine family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct AffineBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = AffineCipher()
        let vectors = AffineVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
