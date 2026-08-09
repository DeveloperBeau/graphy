package textprinter.layout

import scala.collection.mutable.ListBuffer

object Wrapper {
  def wrap(line: String, width: Int): List[String] = {
    val wrapped = ListBuffer.empty[String]
    val current = new StringBuilder
    for (word <- line.split(" ")) {
      if (current.nonEmpty && current.length + 1 + word.length > width) {
        wrapped += current.toString
        current.clear()
      }
      if (current.nonEmpty) current.append(' ')
      current.append(word)
    }
    if (current.nonEmpty) wrapped += current.toString
    if (wrapped.isEmpty) List("") else wrapped.toList
  }
}
