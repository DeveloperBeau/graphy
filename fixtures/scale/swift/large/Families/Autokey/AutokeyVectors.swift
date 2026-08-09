// Known-answer test data captured from AutokeyCipher's own encode().
enum AutokeyVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "IEHRWHAWJJIC"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "BSSHOFCNHAALFAMY"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "LPTVHATKKNMHLRYMP"),
        ]
    }
}
