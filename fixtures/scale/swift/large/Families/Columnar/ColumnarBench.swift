// Benchmark entry point for the columnar family; wraps BenchmarkEngine
// with this family's cipher and known-answer vectors.
struct ColumnarBench {
    private let engine = BenchmarkEngine()

    func measure(iterations: Int) -> BenchSample {
        let cipher = ColumnarCipher()
        let vectors = ColumnarVectors.all()
        return engine.sample(cipher, vectors, iterations)
    }
}
