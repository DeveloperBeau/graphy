import Foundation

final class InputReader {
    let prompt: String

    init(prompt: String) {
        self.prompt = prompt
    }

    func nextLine() -> String? {
        print(prompt, terminator: "")
        return readLine()
    }
}
