// Correctness entry point for the vigenere family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct VigenereRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = VigenereCipher()
        let vectors = VigenereVectors.all()
        return engine.verify(cipher, vectors)
    }
}
