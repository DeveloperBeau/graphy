struct TeaDescriptor: FamilyDescriptor {
    var family: String { "tea" }
    var suite: String { "block" }
    var kind: CipherKind { .block }

    func cipher() -> Cipher {
        return TeaCipher()
    }

    func vectors() -> [TestVector] {
        return TeaVectors.all()
    }
}
