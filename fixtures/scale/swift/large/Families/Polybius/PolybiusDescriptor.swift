struct PolybiusDescriptor: FamilyDescriptor {
    var family: String { "polybius" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return PolybiusCipher()
    }

    func vectors() -> [TestVector] {
        return PolybiusVectors.all()
    }
}
