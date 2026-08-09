// Correctness entry point for the rc4 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Rc4Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Rc4Cipher()
        let vectors = Rc4Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
