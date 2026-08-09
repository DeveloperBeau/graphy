final class Evaluator {
    let environment: Environment
    let functions: FunctionRegistry

    init(environment: Environment, functions: FunctionRegistry) {
        self.environment = environment
        self.functions = functions
    }

    func eval(_ node: Node) throws -> Double {
        switch node {
        case let n as NumberLiteral: return n.value
        case let n as VariableRef: return try environment.resolve(n.name)
        case let n as UnaryOp: return -(try eval(n.operand))
        case let n as BinaryOp: return try BinaryMath.apply(n.op, try eval(n.left), try eval(n.right))
        case let n as FunctionCall:
            let arguments = try n.arguments.map { try eval($0) }
            return try functions.invoke(n.name, arguments)
        case let n as Assignment:
            let value = try eval(n.value)
            environment.assign(n.name, value)
            return value
        default:
            throw EvalError(message: "unsupported node", subject: node.describe())
        }
    }
}
