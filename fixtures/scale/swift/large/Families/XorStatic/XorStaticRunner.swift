// Correctness entry point for the xorstatic family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct XorStaticRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = XorStaticCipher()
        let vectors = XorStaticVectors.all()
        return engine.verify(cipher, vectors)
    }
}
