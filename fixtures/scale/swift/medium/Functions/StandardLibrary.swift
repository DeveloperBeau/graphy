enum StandardLibrary {
    static func buildRegistry() -> FunctionRegistry {
        let registry = FunctionRegistry()
        TrigFunctions.install(registry)
        HyperbolicFunctions.install(registry)
        LogFunctions.install(registry)
        PowerFunctions.install(registry)
        RoundingFunctions.install(registry)
        StatsFunctions.install(registry)
        NumberFunctions.install(registry)
        SequenceFunctions.install(registry)
        return registry
    }
}
