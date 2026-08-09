// Correctness entry point for the gronsfeld family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct GronsfeldRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = GronsfeldCipher()
        let vectors = GronsfeldVectors.all()
        return engine.verify(cipher, vectors)
    }
}
