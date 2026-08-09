enum SuiteMap {
    static func grouped() -> [String: [FamilyDescriptor]] {
        var map: [String: [FamilyDescriptor]] = [:]
        for descriptor in FamilyCatalog.all() {
            map[descriptor.suite, default: []].append(descriptor)
        }
        return map
    }

    static func suiteNames() -> [String] {
        return grouped().keys.sorted()
    }
}
