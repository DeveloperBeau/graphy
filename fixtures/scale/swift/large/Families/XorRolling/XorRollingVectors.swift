// Known-answer test data captured from XorRollingCipher's own encode().
enum XorRollingVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown fox jumps ov", expected: "526f6d297b7e656e652f72637d647a3570786039706e716d6d3f4f57"),
            TestVector(plaintext: "cipher test corpus", expected: "656e78616f792c796b7c6431717c66656364"),
            TestVector(plaintext: "0123456789abcdef", expected: "36363a3a3e3e3a3a3636717371777173"),
        ]
    }
}
