struct BlockReverseDescriptor: FamilyDescriptor {
    var family: String { "blockreverse" }
    var suite: String { "block" }
    var kind: CipherKind { .block }

    func cipher() -> Cipher {
        return BlockReverseCipher()
    }

    func vectors() -> [TestVector] {
        return BlockReverseVectors.all()
    }
}
