package cryptobench.ciphers.atbash

/** Parameters for the atbash cipher. */
final case class AtbashKey(label: String) {
  def describe: String = "atbash/" + label
}

object AtbashKey {
  def default(): AtbashKey = AtbashKey("fixed")
}
