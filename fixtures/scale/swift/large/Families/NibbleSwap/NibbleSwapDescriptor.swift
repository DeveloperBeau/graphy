struct NibbleSwapDescriptor: FamilyDescriptor {
    var family: String { "nibbleswap" }
    var suite: String { "stream" }
    var kind: CipherKind { .byte }

    func cipher() -> Cipher {
        return NibbleSwapCipher()
    }

    func vectors() -> [TestVector] {
        return NibbleSwapVectors.all()
    }
}
