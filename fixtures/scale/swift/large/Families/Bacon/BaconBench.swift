// Benchmark entry point for the bacon family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct BaconBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = BaconCipher()
        let vectors = BaconVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
