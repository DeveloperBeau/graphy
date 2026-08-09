struct AutokeyDescriptor: FamilyDescriptor {
    var family: String { "autokey" }
    var suite: String { "polyalphabetic" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return AutokeyCipher()
    }

    func vectors() -> [TestVector] {
        return AutokeyVectors.all()
    }
}
