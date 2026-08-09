package cryptobench.ciphers.affine

object AffineVectors {
    fun samples(): List<String> = listOf(
        "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP",
        "BRIGHT VIXENS JUMP DOZY FOWL QUACK",
        "JACKDAWS LOVE MY BIG SPHINX OF QUARTZ",
    )

    fun count(): Int = samples().size
}
