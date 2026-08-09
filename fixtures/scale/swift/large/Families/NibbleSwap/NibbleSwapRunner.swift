// Correctness entry point for the nibbleswap family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct NibbleSwapRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = NibbleSwapCipher()
        let vectors = NibbleSwapVectors.all()
        return engine.verify(cipher, vectors)
    }
}
