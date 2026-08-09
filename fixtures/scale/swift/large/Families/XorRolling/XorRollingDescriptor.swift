struct XorRollingDescriptor: FamilyDescriptor {
    var family: String { "xorrolling" }
    var suite: String { "stream" }
    var kind: CipherKind { .byte }

    func cipher() -> Cipher {
        return XorRollingCipher()
    }

    func vectors() -> [TestVector] {
        return XorRollingVectors.all()
    }
}
