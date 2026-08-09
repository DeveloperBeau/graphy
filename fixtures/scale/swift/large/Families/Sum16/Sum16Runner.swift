// Correctness entry point for the sum16 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Sum16Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Sum16Cipher()
        let vectors = Sum16Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
