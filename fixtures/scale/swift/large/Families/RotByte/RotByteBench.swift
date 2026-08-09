// Benchmark entry point for the rotbyte family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct RotByteBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = RotByteCipher()
        let vectors = RotByteVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
