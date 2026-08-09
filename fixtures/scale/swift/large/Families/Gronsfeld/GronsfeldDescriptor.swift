struct GronsfeldDescriptor: FamilyDescriptor {
    var family: String { "gronsfeld" }
    var suite: String { "polyalphabetic" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return GronsfeldCipher()
    }

    func vectors() -> [TestVector] {
        return GronsfeldVectors.all()
    }
}
