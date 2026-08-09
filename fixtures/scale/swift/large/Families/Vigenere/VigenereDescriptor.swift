struct VigenereDescriptor: FamilyDescriptor {
    var family: String { "vigenere" }
    var suite: String { "polyalphabetic" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return VigenereCipher()
    }

    func vectors() -> [TestVector] {
        return VigenereVectors.all()
    }
}
