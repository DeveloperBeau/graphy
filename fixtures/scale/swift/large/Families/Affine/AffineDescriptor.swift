struct AffineDescriptor: FamilyDescriptor {
    var family: String { "affine" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return AffineCipher()
    }

    func vectors() -> [TestVector] {
        return AffineVectors.all()
    }
}
