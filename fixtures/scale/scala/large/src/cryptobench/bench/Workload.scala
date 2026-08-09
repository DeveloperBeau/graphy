package cryptobench.bench

import cryptobench.util.Rng

/** Deterministic plaintext payloads used to size benchmark iterations. */
object Workload {
  def payloads(count: Int): List[String] = {
    val rng = new Rng(0x5EEDL)
    (0 until count).map(i => randomSentence(rng, 8 + (i % 24))).toList
  }

  private[bench] def randomSentence(rng: Rng, words: Int): String = {
    val sb = new StringBuilder
    for (w <- 0 until words) {
      if (w > 0) sb.append(' ')
      val len = 3 + rng.nextInt(7)
      for (_ <- 0 until len) sb.append(('A' + rng.nextInt(26)).toChar)
    }
    sb.toString
  }
}
