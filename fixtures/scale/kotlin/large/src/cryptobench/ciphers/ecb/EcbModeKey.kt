package cryptobench.ciphers.ecb

data class EcbModeKey(
    val blockKey: Long,
) {
    fun rotated(): EcbModeKey = EcbModeKey(java.lang.Long.rotateLeft(blockKey, 8))

    companion object {
        fun default(): EcbModeKey = EcbModeKey(0x5115ABEDCAFED00D)
    }
}
