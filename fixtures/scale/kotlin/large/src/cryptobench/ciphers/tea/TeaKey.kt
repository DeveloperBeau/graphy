package cryptobench.ciphers.tea

data class TeaKey(val k0: Int, val k1: Int, val k2: Int, val k3: Int) {

    fun k(index: Int): Int = when (index and 3) {
        0 -> k0
        1 -> k1
        2 -> k2
        else -> k3
    }

    companion object {
        fun default(): TeaKey = TeaKey(0x01234567, -0x76543211, -0x1234568, 0x76543210)
    }
}
