// Correctness entry point for the xorrolling family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct XorRollingRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = XorRollingCipher()
        let vectors = XorRollingVectors.all()
        return engine.verify(cipher, vectors)
    }
}
