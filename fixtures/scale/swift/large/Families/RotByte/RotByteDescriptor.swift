struct RotByteDescriptor: FamilyDescriptor {
    var family: String { "rotbyte" }
    var suite: String { "stream" }
    var kind: CipherKind { .byte }

    func cipher() -> Cipher {
        return RotByteCipher()
    }

    func vectors() -> [TestVector] {
        return RotByteVectors.all()
    }
}
