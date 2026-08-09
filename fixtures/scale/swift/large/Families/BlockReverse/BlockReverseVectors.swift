// Known-answer test data captured from BlockReverseCipher's own encode().
enum BlockReverseVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown!", expected: "51a19580c5d5a58dad8089c9bdddb984"),
            TestVector(plaintext: "0123456789abcdef", expected: "c0c4c8ccd0d4d8dce0e485898d919599"),
            TestVector(plaintext: "silver marble owl padloc", expected: "cda5b1d995c980b585c989b19580bdddb180c18591b1bd8d"),
        ]
    }
}
