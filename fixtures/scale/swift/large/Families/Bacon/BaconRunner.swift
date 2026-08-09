// Correctness entry point for the bacon family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct BaconRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = BaconCipher()
        let vectors = BaconVectors.all()
        return engine.verify(cipher, vectors)
    }
}
