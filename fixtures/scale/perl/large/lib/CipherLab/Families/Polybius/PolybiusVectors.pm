package CipherLab::Families::Polybius::PolybiusVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from PolybiusCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "DZCMRCVREEDX"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "WNNCJAXICVVGAVHT"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "GKOQCVOFFIHCGMTHK"),
    );
}

1;
