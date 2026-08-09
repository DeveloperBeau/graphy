struct SubstitutionDescriptor: FamilyDescriptor {
    var family: String { "substitution" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return SubstitutionCipher()
    }

    func vectors() -> [TestVector] {
        return SubstitutionVectors.all()
    }
}
