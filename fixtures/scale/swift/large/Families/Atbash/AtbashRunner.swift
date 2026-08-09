// Correctness entry point for the atbash family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct AtbashRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = AtbashCipher()
        let vectors = AtbashVectors.all()
        return engine.verify(cipher, vectors)
    }
}
