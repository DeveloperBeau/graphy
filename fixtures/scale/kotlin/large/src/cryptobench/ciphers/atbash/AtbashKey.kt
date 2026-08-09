package cryptobench.ciphers.atbash

data class AtbashKey(
    val label: String,
) {
    fun describe(): String = "atbash/" + label

    companion object {
        fun default(): AtbashKey = AtbashKey("fixed")
    }
}
