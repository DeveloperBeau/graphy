package CipherLab::Families::Bacon::BaconVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from BaconCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "EYZHKTKEPNKC"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "XMKXCRMVNECLDWGQ"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "HJLLVMDSQROHJNSEF"),
    );
}

1;
