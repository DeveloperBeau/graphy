// Known-answer test data captured from Fnv1a32Cipher's own encode().
enum Fnv1a32Vectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "abc", expected: "1a47e90b"),
            TestVector(plaintext: "hello world", expected: "d58b3fa7"),
            TestVector(plaintext: "The quick brown fox jumps over the lazy dog", expected: "048fff90"),
        ]
    }
}
