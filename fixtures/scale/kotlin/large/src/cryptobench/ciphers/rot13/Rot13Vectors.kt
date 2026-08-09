package cryptobench.ciphers.rot13

object Rot13Vectors {
    fun samples(): List<String> = listOf(
        "PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS",
        "SPHINX OF BLACK QUARTZ JUDGE MY VOW",
        "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP",
    )

    fun count(): Int = samples().size
}
