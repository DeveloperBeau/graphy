package cryptobench.ciphers.simon

/** Simon64-style Feistel rounds built from AND, rotate and xor. */
internal object SimonRounds {
    fun encryptBlock(block: Long, key: SimonKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 0 until 32) {
            val tmp = v0
            v0 = v1 xor (Integer.rotateLeft(v0, 1) and Integer.rotateLeft(v0, 8)) xor Integer.rotateLeft(v0, 2) xor key.k(r and 3)
            v1 = tmp
        }
        return pack(v0, v1)
    }

    fun decryptBlock(block: Long, key: SimonKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 32 - 1 downTo 0) {
            val tmp = v1
            v1 = v0 xor (Integer.rotateLeft(v1, 1) and Integer.rotateLeft(v1, 8)) xor Integer.rotateLeft(v1, 2) xor key.k(r and 3)
            v0 = tmp
        }
        return pack(v0, v1)
    }

    private fun pack(v0: Int, v1: Int): Long =
        (v0.toLong() shl 32) or (v1.toLong() and 0xFFFFFFFFL)
}
