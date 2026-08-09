package calc.io

object Banner {
  private val Version = "2.1.0"

  def render: String = {
    val sb = new StringBuilder
    sb.append("mathwork ").append(Version).append('\n')
    sb.append("type an expression, :help for commands, :quit to exit")
    sb.toString
  }
}
