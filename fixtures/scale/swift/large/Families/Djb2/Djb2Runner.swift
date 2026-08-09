// Correctness entry point for the djb2 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Djb2Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Djb2Cipher()
        let vectors = Djb2Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
