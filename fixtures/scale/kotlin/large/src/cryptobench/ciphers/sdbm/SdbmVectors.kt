package cryptobench.ciphers.sdbm

object SdbmVectors {
    fun samples(): List<String> = listOf(
        "SPHINX OF BLACK QUARTZ JUDGE MY VOW",
        "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP",
        "BRIGHT VIXENS JUMP DOZY FOWL QUACK",
    )

    fun count(): Int = samples().size
}
