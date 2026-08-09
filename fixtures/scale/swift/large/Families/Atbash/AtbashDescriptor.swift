struct AtbashDescriptor: FamilyDescriptor {
    var family: String { "atbash" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return AtbashCipher()
    }

    func vectors() -> [TestVector] {
        return AtbashVectors.all()
    }
}
