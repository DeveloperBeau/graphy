package textprinter.model

class Document private constructor(val lines: List<String>) {

    fun longestLine(): Int = lines.maxOfOrNull { it.length } ?: 0

    companion object {
        fun fromText(text: String): Document =
            Document(text.split("\n").map { it.trimEnd() })
    }
}
