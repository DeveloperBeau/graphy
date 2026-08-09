// Known-answer test data captured from RailfenceCipher's own encode().
enum RailfenceVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "HDGQVGZVIIHB"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "ARRGNEBMGZZKEZLX"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "KOSUGZSJJMLGKQXLO"),
        ]
    }
}
