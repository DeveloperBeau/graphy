import Foundation

enum HexCodec {
    static func toHex(_ bytes: [UInt8]) -> String {
        return bytes.map { String(format: "%02x", $0) }.joined()
    }

    static func fromHex(_ hex: String) -> [UInt8] {
        var bytes: [UInt8] = []
        var i = hex.startIndex
        while i < hex.endIndex {
            let next = hex.index(i, offsetBy: 2)
            bytes.append(UInt8(hex[i..<next], radix: 16) ?? 0)
            i = next
        }
        return bytes
    }
}
