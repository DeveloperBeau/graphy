package cryptobench.ciphers.feistel

data class FeistelKey(val master: Long) {

    fun subKey(round: Int): Int {
        val mixed = master xor (-0x61c8864680b583ebL * (round + 1))
        return (mixed xor (mixed ushr 32)).toInt()
    }

    companion object {
        fun default(): FeistelKey = FeistelKey(0x0F1E2D3C4B5A6978L)
    }
}
