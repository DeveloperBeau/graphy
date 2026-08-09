package cryptobench.ciphers.hill

final case class HillKey(a: Int, b: Int, c: Int, d: Int) {

  def matrix: Array[Int] = Array(a, b, c, d)

  def inverseMatrix: Array[Int] = {
    val det = Math.floorMod(a * d - b * c, 26)
    var detInv = 1
    for (i <- 1 until 26) {
      if (det * i % 26 == 1) detInv = i
    }
    Array(
      Math.floorMod(d * detInv, 26), Math.floorMod(-b * detInv, 26),
      Math.floorMod(-c * detInv, 26), Math.floorMod(a * detInv, 26)
    )
  }
}

object HillKey {
  def default(): HillKey = HillKey(3, 3, 2, 5)
}
