// Known-answer test data captured from CaesarCipher's own encode().
enum CaesarVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "DXYGJSJDOMJB"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "WLJWBQLUMDBKCVFP"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "GIKKULCRPQNGIMRDE"),
        ]
    }
}
