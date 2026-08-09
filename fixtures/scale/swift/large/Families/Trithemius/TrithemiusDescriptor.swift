struct TrithemiusDescriptor: FamilyDescriptor {
    var family: String { "trithemius" }
    var suite: String { "polyalphabetic" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return TrithemiusCipher()
    }

    func vectors() -> [TestVector] {
        return TrithemiusVectors.all()
    }
}
