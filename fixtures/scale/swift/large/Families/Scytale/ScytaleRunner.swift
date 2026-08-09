// Correctness entry point for the scytale family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct ScytaleRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = ScytaleCipher()
        let vectors = ScytaleVectors.all()
        return engine.verify(cipher, vectors)
    }
}
