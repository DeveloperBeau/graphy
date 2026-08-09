// Implemented once per cipher family under Families/<Name>/<Name>Cipher.swift.
protocol Cipher {
    // Short identifier used for reporting and registry lookups.
    var name: String { get }

    // Transforms plaintext into the family's ciphertext representation.
    func encode(_ plaintext: String) -> String

    // Reverses encode; not required to be lossless for hash families.
    func decode(_ ciphertext: String) -> String
}
