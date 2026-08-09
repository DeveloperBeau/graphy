package cryptobench.ciphers.cbc

data class CbcModeKey(val blockKey: Long) {

    fun iv(): ByteArray {
        val iv = ByteArray(8)
        var v = blockKey * -0x61c8864680b583ebL
        for (i in 7 downTo 0) {
            iv[i] = v.toByte()
            v = v ushr 8
        }
        return iv
    }

    companion object {
        fun default(): CbcModeKey = CbcModeKey(0x5115ABEDCAFED00D)
    }
}
