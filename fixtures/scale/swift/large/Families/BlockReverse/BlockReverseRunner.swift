// Correctness entry point for the blockreverse family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct BlockReverseRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = BlockReverseCipher()
        let vectors = BlockReverseVectors.all()
        return engine.verify(cipher, vectors)
    }
}
