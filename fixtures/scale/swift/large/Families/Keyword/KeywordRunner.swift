// Correctness entry point for the keyword family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct KeywordRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = KeywordCipher()
        let vectors = KeywordVectors.all()
        return engine.verify(cipher, vectors)
    }
}
