package cryptobench.core;

/** A named group of checks for one cipher or hash family. */
public interface CipherSuite {
    String name();

    SuiteResult run();

    default String category() {
        return "cipher";
    }
}
