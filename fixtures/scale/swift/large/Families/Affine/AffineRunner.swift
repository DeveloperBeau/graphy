// Correctness entry point for the affine family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct AffineRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = AffineCipher()
        let vectors = AffineVectors.all()
        return engine.verify(cipher, vectors)
    }
}
