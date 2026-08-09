package cryptobench.ciphers.rc4

data class Rc4Key(
    val secret: String,
) {
    fun secretLength(): Int = secret.length

    companion object {
        fun default(): Rc4Key = Rc4Key("quiet-basalt-9")
    }
}
