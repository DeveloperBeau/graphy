// Correctness entry point for the rot13 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Rot13Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Rot13Cipher()
        let vectors = Rot13Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
