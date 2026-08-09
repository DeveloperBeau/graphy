// One timing sample produced by BenchmarkEngine for a single family.
struct BenchSample {
    let family: String
    let nanoseconds: Int
    let iterations: Int

    func perOp() -> Double {
        return iterations == 0 ? 0 : Double(nanoseconds) / Double(iterations)
    }
}
