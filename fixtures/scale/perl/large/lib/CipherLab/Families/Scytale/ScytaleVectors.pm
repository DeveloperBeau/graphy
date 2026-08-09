package CipherLab::Families::Scytale::ScytaleVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from ScytaleCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "ICDLOXOITROG"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "BQOBGVQZRIGPHAKU"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "LNPPZQHWUVSLNRWIJ"),
    );
}

1;
