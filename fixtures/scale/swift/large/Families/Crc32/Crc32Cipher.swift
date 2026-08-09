import Foundation

struct Crc32Cipher: Cipher {
    private let seed: UInt32 = 2166136261
    private let prime: UInt32 = 16777619

    var name: String { "crc32" }

    func encode(_ plaintext: String) -> String {
        var acc = seed
        for b in plaintext.utf8 {
            acc = (acc ^ UInt32(b)) &* prime
        }
        return String(format: "%08x", acc)
    }

    func decode(_ ciphertext: String) -> String {
        return "digest:" + ciphertext
    }
}
