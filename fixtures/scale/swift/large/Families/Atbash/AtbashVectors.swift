// Known-answer test data captured from AtbashCipher's own encode().
enum AtbashVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "FBEOTEXTGGFZ"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "YPPELCZKEXXICXJV"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "IMQSEXQHHKJEIOVJM"),
        ]
    }
}
