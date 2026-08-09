struct KeywordDescriptor: FamilyDescriptor {
    var family: String { "keyword" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return KeywordCipher()
    }

    func vectors() -> [TestVector] {
        return KeywordVectors.all()
    }
}
