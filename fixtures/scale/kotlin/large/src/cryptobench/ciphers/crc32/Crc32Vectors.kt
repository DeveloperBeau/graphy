package cryptobench.ciphers.crc32

object Crc32Vectors {
    fun samples(): List<String> = listOf(
        "BRIGHT VIXENS JUMP DOZY FOWL QUACK",
        "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
        "MEET ME AT THE HARBOUR AT MIDNIGHT",
    )

    fun count(): Int = samples().size
}
