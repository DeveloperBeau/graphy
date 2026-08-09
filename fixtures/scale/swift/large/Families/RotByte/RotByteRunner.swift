// Correctness entry point for the rotbyte family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct RotByteRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = RotByteCipher()
        let vectors = RotByteVectors.all()
        return engine.verify(cipher, vectors)
    }
}
