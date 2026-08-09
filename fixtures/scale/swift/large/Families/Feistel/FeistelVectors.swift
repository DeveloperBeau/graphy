// Known-answer test data captured from FeistelCipher's own encode().
enum FeistelVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown!", expected: "a2432b018bab4b1b5b0113937bbb7309"),
            TestVector(plaintext: "0123456789abcdef", expected: "81899199a1a9b1b9c1c90b131b232b33"),
            TestVector(plaintext: "silver marble owl padloc", expected: "9b4b63b32b93016b0b9313632b017bbb6301830b23637b1b"),
        ]
    }
}
