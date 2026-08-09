import Foundation

struct NibbleSwapCipher: Cipher {
    private let mask = 9

    var name: String { "nibbleswap" }

    func encode(_ plaintext: String) -> String {
        var out = ""
        let bytes = Array(plaintext.utf8)
        for i in 0..<bytes.count {
            let value = Int(bytes[i]) ^ (mask + i)
            out += String(format: "%02x", value & 0xFF)
        }
        return out
    }

    func decode(_ ciphertext: String) -> String {
        var scalars: [UnicodeScalar] = []
        var i = ciphertext.startIndex
        var pos = 0
        while i < ciphertext.endIndex {
            let next = ciphertext.index(i, offsetBy: 2)
            let value = Int(ciphertext[i..<next], radix: 16) ?? 0
            scalars.append(UnicodeScalar(UInt8((value ^ (mask + pos)) & 0xFF)))
            i = next
            pos += 1
        }
        return String(String.UnicodeScalarView(scalars))
    }
}
