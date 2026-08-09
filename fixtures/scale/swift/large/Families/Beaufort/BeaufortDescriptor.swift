struct BeaufortDescriptor: FamilyDescriptor {
    var family: String { "beaufort" }
    var suite: String { "polyalphabetic" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return BeaufortCipher()
    }

    func vectors() -> [TestVector] {
        return BeaufortVectors.all()
    }
}
