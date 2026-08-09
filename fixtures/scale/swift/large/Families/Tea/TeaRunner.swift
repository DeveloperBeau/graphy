// Correctness entry point for the tea family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct TeaRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = TeaCipher()
        let vectors = TeaVectors.all()
        return engine.verify(cipher, vectors)
    }
}
