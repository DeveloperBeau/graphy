import Foundation

struct CaesarCipher: Cipher {
    private let shift = 3
    private let step = 1

    var name: String { "caesar" }

    func encode(_ plaintext: String) -> String {
        var chars = Array(plaintext)
        for i in 0..<chars.count where chars[i].isUppercase {
            let base = Int(chars[i].asciiValue! - 65)
            let shifted = (base + shift + i * step) % 26
            chars[i] = Character(UnicodeScalar(65 + shifted)!)
        }
        return String(chars)
    }

    func decode(_ ciphertext: String) -> String {
        var chars = Array(ciphertext)
        for i in 0..<chars.count where chars[i].isUppercase {
            let base = Int(chars[i].asciiValue! - 65)
            let shifted = (base - shift - i * step + 2600) % 26
            chars[i] = Character(UnicodeScalar(65 + shifted)!)
        }
        return String(chars)
    }
}
