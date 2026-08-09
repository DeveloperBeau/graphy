// Correctness entry point for the railfence family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct RailfenceRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = RailfenceCipher()
        let vectors = RailfenceVectors.all()
        return engine.verify(cipher, vectors)
    }
}
