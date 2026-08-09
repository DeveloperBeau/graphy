struct Djb2Descriptor: FamilyDescriptor {
    var family: String { "djb2" }
    var suite: String { "hash" }
    var kind: CipherKind { .hash }

    func cipher() -> Cipher {
        return Djb2Cipher()
    }

    func vectors() -> [TestVector] {
        return Djb2Vectors.all()
    }
}
