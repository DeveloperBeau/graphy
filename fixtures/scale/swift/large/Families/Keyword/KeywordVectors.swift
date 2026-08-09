// Known-answer test data captured from KeywordCipher's own encode().
enum KeywordVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "FZAILULFQOLD"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "YNLYDSNWOFDMEXHR"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "IKMMWNETRSPIKOTFG"),
        ]
    }
}
