// Benchmark entry point for the vigenere family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct VigenereBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = VigenereCipher()
        let vectors = VigenereVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
