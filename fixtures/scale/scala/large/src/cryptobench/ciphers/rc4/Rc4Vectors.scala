package cryptobench.ciphers.rc4

object Rc4Vectors {
  def samples(): List[String] = List(
      "SPHINX OF BLACK QUARTZ JUDGE MY VOW",
      "HOW VEXINGLY QUICK DAFT ZEBRAS JUMP",
      "BRIGHT VIXENS JUMP DOZY FOWL QUACK"
  )

  def count(): Int = samples().size
}
