// Known-answer test data captured from NibbleSwapCipher's own encode().
enum NibbleSwapVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown fox jumps ov", expected: "5d626e2c7c7b66737a3271667a6179387f75633c776b725052024c52"),
            TestVector(plaintext: "cipher test corpus", expected: "6a637b64687c2f6474616734767965686c69"),
            TestVector(plaintext: "0123456789abcdef", expected: "393b393f393b3927292b72767672727e"),
        ]
    }
}
