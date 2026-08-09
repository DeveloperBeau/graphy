// Known-answer test data captured from BeaufortCipher's own encode().
enum BeaufortVectors {
    static func all() -> [TestVector] {
        return [
            TestVector(plaintext: "ATTACKATDAWN", expected: "JDEMPYPJUSPH"),
            TestVector(plaintext: "THEQUICKBROWNFOX", expected: "CRPCHWRASJHQIBLV"),
            TestVector(plaintext: "DEFENDTHEEASTWALL", expected: "MOQQARIXVWTMOSXJK"),
        ]
    }
}
