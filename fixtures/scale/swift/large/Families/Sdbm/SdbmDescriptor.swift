struct SdbmDescriptor: FamilyDescriptor {
    var family: String { "sdbm" }
    var suite: String { "hash" }
    var kind: CipherKind { .hash }

    func cipher() -> Cipher {
        return SdbmCipher()
    }

    func vectors() -> [TestVector] {
        return SdbmVectors.all()
    }
}
