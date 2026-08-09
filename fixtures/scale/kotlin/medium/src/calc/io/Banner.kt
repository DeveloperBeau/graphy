package calc.io

private const val VERSION = "2.1.0"

fun banner(): String {
    val sb = StringBuilder()
    sb.append("mathwork ").append(VERSION).append('\n')
    sb.append("type an expression, :help for commands, :quit to exit")
    return sb.toString()
}
