// A single known-answer pair used to check a Cipher implementation.
//
// plaintext -> expected must round-trip through encode()/decode()
// for every non-hash family; hash families only check encode().
// Vectors live one array per family under Families/<Name>/<Name>Vectors.swift,
// generated once and reused by both the correctness and bench runners.
struct TestVector {
    let plaintext: String
    let expected: String
}
