struct Crc32Descriptor: FamilyDescriptor {
    var family: String { "crc32" }
    var suite: String { "hash" }
    var kind: CipherKind { .hash }

    func cipher() -> Cipher {
        return Crc32Cipher()
    }

    func vectors() -> [TestVector] {
        return Crc32Vectors.all()
    }
}
