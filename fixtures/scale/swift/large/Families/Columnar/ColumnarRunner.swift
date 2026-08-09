// Correctness entry point for the columnar family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct ColumnarRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = ColumnarCipher()
        let vectors = ColumnarVectors.all()
        return engine.verify(cipher, vectors)
    }
}
