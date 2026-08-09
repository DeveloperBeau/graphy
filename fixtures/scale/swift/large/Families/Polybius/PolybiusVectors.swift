// Known-answer test data captured from PolybiusCipher's own encode().
enum PolybiusVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "DZCMRCVREEDX"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "WNNCJAXICVVGAVHT"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "GKOQCVOFFIHCGMTHK"),
        ]
    }
}
