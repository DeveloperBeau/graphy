package cryptobench.util

import java.nio.charset.StandardCharsets

object Bytes {
  def of(text: String): Array[Byte] = text.getBytes(StandardCharsets.UTF_8)

  def toText(data: Array[Byte]): String = new String(data, StandardCharsets.UTF_8)

  def pad(data: Array[Byte], blockSize: Int): Array[Byte] = {
    val rem = data.length % blockSize
    if (rem == 0) data else java.util.Arrays.copyOf(data, data.length + blockSize - rem)
  }
}
