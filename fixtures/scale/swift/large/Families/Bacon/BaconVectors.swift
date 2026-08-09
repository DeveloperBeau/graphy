// Known-answer test data captured from BaconCipher's own encode().
enum BaconVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "EYZHKTKEPNKC"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "XMKXCRMVNECLDWGQ"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "HJLLVMDSQROHJNSEF"),
        ]
    }
}
