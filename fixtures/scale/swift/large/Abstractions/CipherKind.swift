// Broad shape of a cipher family, used to group families in reports
// and to pick sensible default test-vector plaintexts.
//
// letter: 26-letter alphabet substitution/transposition ciphers.
// byte/block/hash: operate on the UTF-8 byte stream directly.
enum CipherKind {
    case letter
    case byte
    case block
    case hash
}
