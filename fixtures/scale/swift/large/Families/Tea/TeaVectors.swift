// Known-answer test data captured from TeaCipher's own encode().
enum TeaVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown!", expected: "a8d0ca40e2ead2c6d640c4e4deeedc42"),
            TestVector(plaintext: "0123456789abcdef", expected: "60626466686a6c6e7072c2c4c6c8cacc"),
            TestVector(plaintext: "silver marble owl padloc", expected: "e6d2d8eccae440dac2e4c4d8ca40deeed840e0c2c8d8dec6"),
        ]
    }
}
