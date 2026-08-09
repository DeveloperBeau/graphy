package cryptobench.util

/** Big-endian 64-bit block packing shared by the block ciphers. */
object BlockCodec {
    fun read(data: ByteArray, at: Int): Long {
        var value = 0L
        for (i in 0 until 8) {
            value = (value shl 8) or (data[at + i].toLong() and 0xFF)
        }
        return value
    }

    fun write(data: ByteArray, at: Int, value: Long) {
        var v = value
        for (i in 7 downTo 0) {
            data[at + i] = v.toByte()
            v = v ushr 8
        }
    }
}
