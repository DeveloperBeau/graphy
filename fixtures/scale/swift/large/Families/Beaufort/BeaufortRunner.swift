// Correctness entry point for the beaufort family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct BeaufortRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = BeaufortCipher()
        let vectors = BeaufortVectors.all()
        return engine.verify(cipher, vectors)
    }
}
