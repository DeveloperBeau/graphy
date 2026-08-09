// Correctness entry point for the fnv1a32 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Fnv1a32Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Fnv1a32Cipher()
        let vectors = Fnv1a32Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
