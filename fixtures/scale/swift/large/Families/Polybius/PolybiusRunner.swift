// Correctness entry point for the polybius family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct PolybiusRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = PolybiusCipher()
        let vectors = PolybiusVectors.all()
        return engine.verify(cipher, vectors)
    }
}
