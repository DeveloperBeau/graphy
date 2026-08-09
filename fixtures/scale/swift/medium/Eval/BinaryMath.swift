import Foundation

enum BinaryMath {
    static func apply(_ op: String, _ left: Double, _ right: Double) throws -> Double {
        switch op {
        case "+": return left + right
        case "-": return left - right
        case "*": return left * right
        case "/":
            guard right != 0 else { throw EvalError(message: "division by zero", subject: op) }
            return left / right
        case "%": return left.truncatingRemainder(dividingBy: right)
        case "^": return pow(left, right)
        default: throw EvalError(message: "unknown operator", subject: op)
        }
    }
}
