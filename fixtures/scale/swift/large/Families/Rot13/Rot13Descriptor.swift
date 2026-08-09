struct Rot13Descriptor: FamilyDescriptor {
    var family: String { "rot13" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return Rot13Cipher()
    }

    func vectors() -> [TestVector] {
        return Rot13Vectors.all()
    }
}
