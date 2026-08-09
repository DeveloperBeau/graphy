final class MemoryStore {
    private var slot: Double = 0

    func store(_ value: Double) {
        slot = value
    }

    func recall() -> Double {
        return slot
    }

    func accumulate(_ value: Double) {
        slot += value
    }

    func clear() {
        slot = 0
    }
}
