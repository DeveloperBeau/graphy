// Correctness entry point for the lcgstream family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct LcgStreamRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = LcgStreamCipher()
        let vectors = LcgStreamVectors.all()
        return engine.verify(cipher, vectors)
    }
}
