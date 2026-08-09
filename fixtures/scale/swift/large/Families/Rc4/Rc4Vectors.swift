// Known-answer test data captured from Rc4Cipher's own encode().
enum Rc4Vectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown fox jumps ov", expected: "53606c2a7a79646d643073607c637b367177613a7169706e6c004e54"),
            TestVector(plaintext: "cipher test corpus", expected: "646179626e7e2d7a6a636532707b6766626b"),
            TestVector(plaintext: "0123456789abcdef", expected: "37393b393f393b393729707070707070"),
        ]
    }
}
