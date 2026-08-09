import Foundation

final class Repl {
    let context: ReplContext
    let reader: InputReader

    init(context: ReplContext) {
        self.context = context
        self.reader = InputReader(prompt: "calc> ")
    }

    func run() {
        let evaluator = Evaluator(environment: context.environment, functions: context.functions)
        while context.settings.running, let line = reader.nextLine() {
            if line.trimmingCharacters(in: .whitespaces).isEmpty { continue }
            if line.hasPrefix(":") {
                print(CommandRouter.dispatch(line, context))
                continue
            }
            guard let node = try? Parser(line).parseStatement(),
                  let value = try? evaluator.eval(node) else { continue }
            context.history.append(line.trimmingCharacters(in: .whitespaces), value)
            print(ResultFormatter.formatResult(value, context.settings))
        }
    }
}
