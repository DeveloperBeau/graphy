package cryptobench.core

/** A named group of checks for one cipher or hash family. */
interface CipherSuite {
    String name()

    SuiteResult run()

    String category()
}
