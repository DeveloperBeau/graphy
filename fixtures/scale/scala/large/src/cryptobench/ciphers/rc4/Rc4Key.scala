package cryptobench.ciphers.rc4

/** Parameters for the rc4 cipher. */
final case class Rc4Key(secret: String) {
  def secretLength: Int = secret.length
}

object Rc4Key {
  def default(): Rc4Key = Rc4Key("quiet-basalt-9")
}
