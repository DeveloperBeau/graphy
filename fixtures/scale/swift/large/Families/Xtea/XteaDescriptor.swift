struct XteaDescriptor: FamilyDescriptor {
    var family: String { "xtea" }
    var suite: String { "block" }
    var kind: CipherKind { .block }

    func cipher() -> Cipher {
        return XteaCipher()
    }

    func vectors() -> [TestVector] {
        return XteaVectors.all()
    }
}
