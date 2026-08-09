// Correctness entry point for the autokey family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct AutokeyRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = AutokeyCipher()
        let vectors = AutokeyVectors.all()
        return engine.verify(cipher, vectors)
    }
}
