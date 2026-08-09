package CipherLab::Families::Djb2::Djb2Vectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from Djb2Cipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("abc", "1a47e90b"),
        CipherLab::TestVector->new("hello world", "d58b3fa7"),
        CipherLab::TestVector->new("The quick brown fox jumps over the lazy dog", "048fff90"),
    );
}

1;
