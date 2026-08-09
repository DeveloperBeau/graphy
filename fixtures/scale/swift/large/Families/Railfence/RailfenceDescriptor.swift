struct RailfenceDescriptor: FamilyDescriptor {
    var family: String { "railfence" }
    var suite: String { "transposition" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return RailfenceCipher()
    }

    func vectors() -> [TestVector] {
        return RailfenceVectors.all()
    }
}
