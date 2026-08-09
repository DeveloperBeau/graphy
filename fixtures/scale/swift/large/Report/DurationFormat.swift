// Renders a per-operation duration in whichever unit reads best.
//
// Used by SuiteReport when a --bench run is requested; the plain
// summary output only needs pass/fail counts, not timings.
enum DurationFormat {
    static func perOp(_ nanos: Double) -> String {
        if nanos < 1000 {
            return String(format: "%.1fns", nanos)
        }
        return String(format: "%.1fus", nanos / 1000)
    }
}
