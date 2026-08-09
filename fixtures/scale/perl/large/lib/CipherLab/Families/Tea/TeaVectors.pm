package CipherLab::Families::Tea::TeaVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from TeaCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("The quick brown!", "a8d0ca40e2ead2c6d640c4e4deeedc42"),
        CipherLab::TestVector->new("0123456789abcdef", "60626466686a6c6e7072c2c4c6c8cacc"),
        CipherLab::TestVector->new("silver marble owl padloc", "e6d2d8eccae440dac2e4c4d8ca40deeed840e0c2c8d8dec6"),
    );
}

1;
