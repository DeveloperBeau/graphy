package cryptobench.core

/** A named group of checks for one cipher or hash family. */
trait CipherSuite {
  def name: String

  def run(): SuiteResult

  def category: String = "cipher"
}
