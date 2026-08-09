package CipherLab::Families::Xtea::XteaVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from XteaCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("The quick brown!", "51a19580c5d5a58dad8089c9bdddb984"),
        CipherLab::TestVector->new("0123456789abcdef", "c0c4c8ccd0d4d8dce0e485898d919599"),
        CipherLab::TestVector->new("silver marble owl padloc", "cda5b1d995c980b585c989b19580bdddb180c18591b1bd8d"),
    );
}

1;
