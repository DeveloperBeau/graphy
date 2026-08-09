// Correctness entry point for the caesar family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct CaesarRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = CaesarCipher()
        let vectors = CaesarVectors.all()
        return engine.verify(cipher, vectors)
    }
}
