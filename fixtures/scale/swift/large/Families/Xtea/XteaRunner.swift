// Correctness entry point for the xtea family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct XteaRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = XteaCipher()
        let vectors = XteaVectors.all()
        return engine.verify(cipher, vectors)
    }
}
