// Correctness entry point for the substitution family; wraps CorrectnessEngine
// with this family's cipher and known-answer vectors.
struct SubstitutionRunner {
    private let engine = CorrectnessEngine()

    func check() -> VectorOutcome {
        let cipher = SubstitutionCipher()
        let vectors = SubstitutionVectors.all()
        return engine.verify(cipher, vectors)
    }
}
