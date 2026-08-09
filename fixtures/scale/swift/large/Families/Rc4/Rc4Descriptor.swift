struct Rc4Descriptor: FamilyDescriptor {
    var family: String { "rc4" }
    var suite: String { "stream" }
    var kind: CipherKind { .byte }

    func cipher() -> Cipher {
        return Rc4Cipher()
    }

    func vectors() -> [TestVector] {
        return Rc4Vectors.all()
    }
}
