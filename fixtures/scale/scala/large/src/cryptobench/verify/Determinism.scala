package cryptobench.verify

import cryptobench.core.HashFunction

object Determinism {
  def stable(hash: HashFunction, sample: String): Boolean =
    hash.digest(sample) == hash.digest(sample)

  def distinct(hash: HashFunction, left: String, right: String): Boolean = {
    if (left == right) true
    else hash.digest(left) != hash.digest(right)
  }
}
