struct ScytaleDescriptor: FamilyDescriptor {
    var family: String { "scytale" }
    var suite: String { "transposition" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return ScytaleCipher()
    }

    func vectors() -> [TestVector] {
        return ScytaleVectors.all()
    }
}
