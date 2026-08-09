// Known-answer test data captured from XorStaticCipher's own encode().
enum XorStaticVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown fox jumps ov", expected: "516e6228787f626f662e6d627e657d3473796f38736f766c6e3e7056"),
            TestVector(plaintext: "cipher test corpus", expected: "666f77606c782b78687d7b30727d61646065"),
            TestVector(plaintext: "0123456789abcdef", expected: "3537353b3d3f3d3b35376e7272767672"),
        ]
    }
}
