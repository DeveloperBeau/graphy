package cryptobench.ciphers.speck

/** Speck64-style ARX rounds: rotate, add, xor. */
internal object SpeckRounds {
    fun encryptBlock(block: Long, key: SpeckKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 0 until 27) {
            v0 = (Integer.rotateRight(v0, 8) + v1) xor key.k(r and 3)
            v1 = Integer.rotateLeft(v1, 3) xor v0
        }
        return pack(v0, v1)
    }

    fun decryptBlock(block: Long, key: SpeckKey): Long {
        var v0 = (block ushr 32).toInt()
        var v1 = block.toInt()
        for (r in 27 - 1 downTo 0) {
            v1 = Integer.rotateRight(v1 xor v0, 3)
            v0 = Integer.rotateLeft((v0 xor key.k(r and 3)) - v1, 8)
        }
        return pack(v0, v1)
    }

    private fun pack(v0: Int, v1: Int): Long =
        (v0.toLong() shl 32) or (v1.toLong() and 0xFFFFFFFFL)
}
