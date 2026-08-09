package CipherLab::Families::LcgStream::LcgStreamVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from LcgStreamCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("The quick brown fox jumps ov", "5c616f2b7d78676c7b3170617b6278377e76623b7668736f53014d55"),
        CipherLab::TestVector->new("cipher test corpus", "6b607a63697f2e7b75626633777a64676d6a"),
        CipherLab::TestVector->new("0123456789abcdef", "38383838383838382828737177717371"),
    );
}

1;
