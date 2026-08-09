package cryptobench.ciphers.route

data class RouteKey(
    val width: Int,
) {
    fun rowCountFor(length: Int): Int = (length + width - 1) / width

    companion object {
        fun default(): RouteKey = RouteKey(6)
    }
}
