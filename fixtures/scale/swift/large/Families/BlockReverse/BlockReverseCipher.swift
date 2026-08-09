import Foundation

struct BlockReverseCipher: Cipher {
    private let rounds = 2

    var name: String { "blockreverse" }

    func encode(_ plaintext: String) -> String {
        var out = ""
        let bytes = Array(plaintext.utf8)
        for b in bytes {
            let rotated = ((Int(b) << rounds) | (Int(b) >> (8 - rounds))) & 0xFF
            out += String(format: "%02x", rotated)
        }
        return out
    }

    func decode(_ ciphertext: String) -> String {
        var scalars: [UnicodeScalar] = []
        var i = ciphertext.startIndex
        while i < ciphertext.endIndex {
            let next = ciphertext.index(i, offsetBy: 2)
            let value = Int(ciphertext[i..<next], radix: 16) ?? 0
            let back = ((value >> rounds) | (value << (8 - rounds))) & 0xFF
            scalars.append(UnicodeScalar(UInt8(back)))
            i = next
        }
        return String(String.UnicodeScalarView(scalars))
    }
}
