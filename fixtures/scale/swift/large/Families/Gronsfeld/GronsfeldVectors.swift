// Known-answer test data captured from GronsfeldCipher's own encode().
enum GronsfeldVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "DYAJNXPKWVTM"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "WMLZFVRBUMLVOITE"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "GJMNYQIYXZXRUZFSU"),
        ]
    }
}
