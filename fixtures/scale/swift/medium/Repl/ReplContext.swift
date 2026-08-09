final class ReplContext {
    let environment = Environment()
    let functions = StandardLibrary.buildRegistry()
    let history = HistoryLog()
    let memory = MemoryStore()
    var settings: Settings

    init(settings: Settings) {
        self.settings = settings
    }
}
