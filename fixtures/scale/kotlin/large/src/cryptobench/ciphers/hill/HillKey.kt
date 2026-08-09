package cryptobench.ciphers.hill

data class HillKey(val a: Int, val b: Int, val c: Int, val d: Int) {

    fun matrix(): IntArray = intArrayOf(a, b, c, d)

    fun inverseMatrix(): IntArray {
        val det = Math.floorMod(a * d - b * c, 26)
        var detInv = 1
        for (i in 1 until 26) {
            if (det * i % 26 == 1) detInv = i
        }
        return intArrayOf(
            Math.floorMod(d * detInv, 26), Math.floorMod(-b * detInv, 26),
            Math.floorMod(-c * detInv, 26), Math.floorMod(a * detInv, 26),
        )
    }

    companion object {
        fun default(): HillKey = HillKey(3, 3, 2, 5)
    }
}
