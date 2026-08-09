// Correctness entry point for the feistel family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct FeistelRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = FeistelCipher()
        let vectors = FeistelVectors.all()
        return engine.verify(cipher, vectors)
    }
}
