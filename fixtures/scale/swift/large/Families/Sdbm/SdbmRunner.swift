// Correctness entry point for the sdbm family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct SdbmRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = SdbmCipher()
        let vectors = SdbmVectors.all()
        return engine.verify(cipher, vectors)
    }
}
