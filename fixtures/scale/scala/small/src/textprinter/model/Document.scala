package textprinter.model

final class Document private (val lines: List[String]) {

  def longestLine: Int =
    if (lines.isEmpty) 0 else lines.map(_.length).max
}

object Document {
  def fromText(text: String): Document =
    new Document(text.split("\n").toList.map(_.replaceAll("\\s+$", "")))
}
