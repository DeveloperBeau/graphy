package cryptobench.ciphers.affine

data class AffineKey(val a: Int, val b: Int) {

    fun inverseOfA(): Int {
        for (candidate in 1 until 26) {
            if (a * candidate % 26 == 1) return candidate
        }
        error("a is not coprime with 26")
    }

    companion object {
        fun default(): AffineKey = AffineKey(5, 8)
    }
}
