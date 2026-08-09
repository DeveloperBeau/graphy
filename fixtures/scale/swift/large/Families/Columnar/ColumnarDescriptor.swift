struct ColumnarDescriptor: FamilyDescriptor {
    var family: String { "columnar" }
    var suite: String { "transposition" }
    var kind: CipherKind { .letter }

    func cipher() -> Cipher {
        return ColumnarCipher()
    }

    func vectors() -> [TestVector] {
        return ColumnarVectors.all()
    }
}
