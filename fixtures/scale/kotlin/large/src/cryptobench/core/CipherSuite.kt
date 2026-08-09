package cryptobench.core

/** A named group of checks for one cipher or hash family. */
interface CipherSuite {
    fun name(): String

    fun run(): SuiteResult

    fun category(): String = "cipher"
}
