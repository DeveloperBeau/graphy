package cryptobench.ciphers.pearson

import cryptobench.core.HashFunction
import cryptobench.util.Bytes
import cryptobench.util.Rng

/** Pearson hashing over a shuffled permutation table. */
final class PearsonHash extends HashFunction {
  private val table = buildTable()

  override def name: String = "pearson"

  override def digest(input: String): Long = {
    var out = 0L
    for (lane <- 0 until 8) {
      var h = lane
      for (b <- Bytes.of(input)) {
        h = table((h ^ (b & 0xFF)) & 0xFF)
      }
      out = (out << 8) | h.toLong
    }
    out
  }

  private def buildTable(): Array[Int] = {
    val t = Array.tabulate(256)(identity)
    val rng = new Rng(0xBADC0DEL)
    for (i <- 255 to 1 by -1) {
      val j = rng.nextInt(i + 1)
      val tmp = t(i); t(i) = t(j); t(j) = tmp
    }
    t
  }
}
