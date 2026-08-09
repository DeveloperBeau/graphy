struct LcgStreamDescriptor: FamilyDescriptor {
    var family: String { "lcgstream" }
    var suite: String { "stream" }
    var kind: CipherKind { .byte }

    func cipher() -> Cipher {
        return LcgStreamCipher()
    }

    func vectors() -> [TestVector] {
        return LcgStreamVectors.all()
    }
}
