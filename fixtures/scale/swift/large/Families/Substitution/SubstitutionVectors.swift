// Known-answer test data captured from SubstitutionCipher's own encode().
enum SubstitutionVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "GBDMQASNZYWP"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "ZPOCIYUEXPOYRLWH"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "JMPQBTLBACAUXCIVX"),
        ]
    }
}
