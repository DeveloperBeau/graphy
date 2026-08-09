package CipherLab::Families::XorRolling::XorRollingVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from XorRollingCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("The quick brown fox jumps ov", "526f6d297b7e656e652f72637d647a3570786039706e716d6d3f4f57"),
        CipherLab::TestVector->new("cipher test corpus", "656e78616f792c796b7c6431717c66656364"),
        CipherLab::TestVector->new("0123456789abcdef", "36363a3a3e3e3a3a3636717371777173"),
    );
}

1;
