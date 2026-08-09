struct CorrectnessEngine {
    func verify(_ cipher: Cipher, _ vectors: [TestVector]) -> VectorOutcome {
        for vector in vectors {
            let encoded = cipher.encode(vector.plaintext)
            if encoded != vector.expected {
                return VectorOutcome(family: cipher.name, passed: false,
                                      detail: "encode mismatch for " + vector.plaintext)
            }
            let decoded = cipher.decode(encoded)
            if decoded.isEmpty && !vector.plaintext.isEmpty {
                return VectorOutcome(family: cipher.name, passed: false, detail: "empty decode")
            }
        }
        return VectorOutcome(family: cipher.name, passed: true, detail: "ok")
    }
}
