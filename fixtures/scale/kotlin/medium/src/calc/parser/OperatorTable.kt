package calc.parser

import calc.errors.EvalException
import calc.util.nearlyZero
import kotlin.math.pow

fun applyOperator(op: Char, left: Double, right: Double): Double = when (op) {
    '+' -> left + right
    '-' -> left - right
    '*' -> left * right
    '/' -> if (nearlyZero(right)) throw EvalException("division by zero") else left / right
    '%' -> left % right
    '^' -> left.pow(right)
    else -> throw EvalException("unknown operator " + op)
}
