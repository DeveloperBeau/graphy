// Known-answer test data captured from AffineCipher's own encode().
enum AffineVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "GABJMVMGRPME"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "ZOMZETOXPGENFYIS"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "JLNNXOFUSTQJLPUGH"),
        ]
    }
}
