package CipherLab::Families::Railfence::RailfenceVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from RailfenceCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "HDGQVGZVIIHB"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "ARRGNEBMGZZKEZLX"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "KOSUGZSJJMLGKQXLO"),
    );
}

1;
