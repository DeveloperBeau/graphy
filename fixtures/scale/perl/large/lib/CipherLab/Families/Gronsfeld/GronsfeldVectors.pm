package CipherLab::Families::Gronsfeld::GronsfeldVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from GronsfeldCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "DYAJNXPKWVTM"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "WMLZFVRBUMLVOITE"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "GJMNYQIYXZXRUZFSU"),
    );
}

1;
