// Known-answer test data captured from RotByteCipher's own encode().
enum RotByteVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "The quick brown fox jumps ov", expected: "576c6026767d6069602c6f7c60677f32757b6d367d6d746a683c7268"),
            TestVector(plaintext: "cipher test corpus", expected: "606d756e627a297e6e7f792e6c7f63626667"),
            TestVector(plaintext: "0123456789abcdef", expected: "33353735333d3f3d33356c6c6c747474"),
        ]
    }
}
