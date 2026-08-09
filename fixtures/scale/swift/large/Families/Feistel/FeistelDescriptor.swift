struct FeistelDescriptor: FamilyDescriptor {
    var family: String { "feistel" }
    var suite: String { "block" }
    var kind: CipherKind { .block }

    func cipher() -> Cipher {
        return FeistelCipher()
    }

    func vectors() -> [TestVector] {
        return FeistelVectors.all()
    }
}
