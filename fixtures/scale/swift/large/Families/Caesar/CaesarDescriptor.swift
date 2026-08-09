struct CaesarDescriptor: FamilyDescriptor {
    var family: String { "caesar" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return CaesarCipher()
    }

    func vectors() -> [TestVector] {
        return CaesarVectors.all()
    }
}
