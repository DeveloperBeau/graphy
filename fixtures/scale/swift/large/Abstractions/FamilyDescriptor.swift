// Metadata plus factory methods for one cipher family; every family
// under Families/ provides exactly one conforming type.
//
// FamilyCatalog.all() collects one instance of each descriptor,
// which is how Harness discovers every family to run.
protocol FamilyDescriptor {
    var family: String { get }
    var suite: String { get }
    var kind: CipherKind { get }
    func cipher() -> Cipher
    func vectors() -> [TestVector]
}
