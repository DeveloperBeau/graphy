package cryptobench.verify

import cryptobench.core.HashFunction

fun stableDigest(hash: HashFunction, sample: String): Boolean =
    hash.digest(sample) == hash.digest(sample)

fun distinctDigests(hash: HashFunction, left: String, right: String): Boolean {
    if (left == right) return true
    return hash.digest(left) != hash.digest(right)
}
