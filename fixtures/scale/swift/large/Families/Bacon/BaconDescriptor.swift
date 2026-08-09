struct BaconDescriptor: FamilyDescriptor {
    var family: String { "bacon" }
    var suite: String { "classical" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return BaconCipher()
    }

    func vectors() -> [TestVector] {
        return BaconVectors.all()
    }
}
