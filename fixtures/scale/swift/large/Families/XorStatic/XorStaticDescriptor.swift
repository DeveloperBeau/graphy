struct XorStaticDescriptor: FamilyDescriptor {
    var family: String { "xorstatic" }
    var suite: String { "stream" }
    var kind: CipherKind { .byte }

    func cipher() -> Cipher {
        return XorStaticCipher()
    }

    func vectors() -> [TestVector] {
        return XorStaticVectors.all()
    }
}
