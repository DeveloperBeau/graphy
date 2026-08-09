// Correctness entry point for the trithemius family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct TrithemiusRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = TrithemiusCipher()
        let vectors = TrithemiusVectors.all()
        return engine.verify(cipher, vectors)
    }
}
