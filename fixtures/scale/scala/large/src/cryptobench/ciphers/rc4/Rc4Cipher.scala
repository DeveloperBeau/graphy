package cryptobench.ciphers.rc4

import cryptobench.core.Cipher
import cryptobench.util.Bytes
import cryptobench.util.Hex

final class Rc4Cipher(key: Rc4Key) extends Cipher {
  private val keyBytes = Bytes.of(key.secret)

  override def name: String = "rc4"

  override def encrypt(plaintext: String): String = Hex.encode(stream(Bytes.of(plaintext)))

  override def decrypt(ciphertext: String): String = Bytes.toText(stream(Hex.decode(ciphertext)))

  private def stream(data: Array[Byte]): Array[Byte] = {
    val s = Array.tabulate(256)(identity)
    var j = 0
    for (i <- 0 until 256) {
      j = (j + s(i) + (keyBytes(i % keyBytes.length) & 0xFF)) & 0xFF
      val tmp = s(i); s(i) = s(j); s(j) = tmp
    }
    val out = new Array[Byte](data.length)
    var x = 0
    var y = 0
    for (n <- data.indices) {
      x = (x + 1) & 0xFF
      y = (y + s(x)) & 0xFF
      val tmp = s(x); s(x) = s(y); s(y) = tmp
      out(n) = (data(n) ^ s((s(x) + s(y)) & 0xFF)).toByte
    }
    out
  }
}
