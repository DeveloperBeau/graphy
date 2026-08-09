struct Sum16Descriptor: FamilyDescriptor {
    var family: String { "sum16" }
    var suite: String { "hash" }
    var kind: CipherKind { .hash }

    func cipher() -> Cipher {
        return Sum16Cipher()
    }

    func vectors() -> [TestVector] {
        return Sum16Vectors.all()
    }
}
