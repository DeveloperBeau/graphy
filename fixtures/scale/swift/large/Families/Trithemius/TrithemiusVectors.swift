// Known-answer test data captured from TrithemiusCipher's own encode().
enum TrithemiusVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "EADNSDWSFFEY"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "XOODKBYJDWWHBWIU"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "HLPRDWPGGJIDHNUIL"),
        ]
    }
}
