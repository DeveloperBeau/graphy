// Known-answer test data captured from ScytaleCipher's own encode().
enum ScytaleVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "ICDLOXOITROG"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "BQOBGVQZRIGPHAKU"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "LNPPZQHWUVSLNRWIJ"),
        ]
    }
}
