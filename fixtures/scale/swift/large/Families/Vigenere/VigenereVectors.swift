// Known-answer test data captured from VigenereCipher's own encode().
enum VigenereVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "HCENRBTOAZXQ"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "AQPDJZVFYQPZSMXI"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "KNQRCUMCBDBVYDJWY"),
        ]
    }
}
