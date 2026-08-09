package cryptobench.util

object Bytes {
    fun of(text: String): ByteArray = text.toByteArray(Charsets.UTF_8)

    fun toText(data: ByteArray): String = String(data, Charsets.UTF_8)

    fun pad(data: ByteArray, blockSize: Int): ByteArray {
        val rem = data.size % blockSize
        if (rem == 0) return data
        return data.copyOf(data.size + blockSize - rem)
    }
}
