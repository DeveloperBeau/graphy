// Correctness entry point for the adler32 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Adler32Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Adler32Cipher()
        let vectors = Adler32Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
