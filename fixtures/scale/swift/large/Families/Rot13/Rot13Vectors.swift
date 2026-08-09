// Known-answer test data captured from Rot13Cipher's own encode().
enum Rot13Vectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "EZBKOYQLXWUN"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "XNMAGWSCVNMWPJUF"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "HKNOZRJZYAYSVAGTV"),
        ]
    }
}
