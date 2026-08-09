struct Fnv1a32Descriptor: FamilyDescriptor {
    var family: String { "fnv1a32" }
    var suite: String { "hash" }
    var kind: CipherKind { .hash }

    func cipher() -> Cipher {
        return Fnv1a32Cipher()
    }

    func vectors() -> [TestVector] {
        return Fnv1a32Vectors.all()
    }
}
