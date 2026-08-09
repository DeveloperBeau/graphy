package cryptobench.ciphers.ctr

data class CtrModeKey(
    val blockKey: Long,
) {
    fun nonce(): Long = blockKey xor 0xC0DEC0DEL

    companion object {
        fun default(): CtrModeKey = CtrModeKey(0x5115ABEDCAFED00D)
    }
}
