package cryptobench.core

/**
 * A reversible cipher under test. Implementations normalise their input
 * (usually to the A-Z alphabet) before transforming it, so decrypt(encrypt(x))
 * is compared against the normalised plaintext, not the raw string.
 */
interface Cipher {
    String name()

    String encrypt(String plaintext)

    String decrypt(String ciphertext)
}
