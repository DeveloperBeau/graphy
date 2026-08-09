struct Adler32Descriptor: FamilyDescriptor {
    var family: String { "adler32" }
    var suite: String { "hash" }
    var kind: CipherKind { .hash }

    func cipher() -> Cipher {
        return Adler32Cipher()
    }

    func vectors() -> [TestVector] {
        return Adler32Vectors.all()
    }
}
