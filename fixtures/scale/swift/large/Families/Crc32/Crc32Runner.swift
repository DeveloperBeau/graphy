// Correctness entry point for the crc32 family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct Crc32Runner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = Crc32Cipher()
        let vectors = Crc32Vectors.all()
        return engine.verify(cipher, vectors)
    }
}
