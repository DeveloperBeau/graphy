// Known-answer test data captured from ColumnarCipher's own encode().
enum ColumnarVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "JEGPTDVQCBZS"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "CSRFLBXHASRBUOZK"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "MPSTEWOEDFDXAFLYA"),
        ]
    }
}
