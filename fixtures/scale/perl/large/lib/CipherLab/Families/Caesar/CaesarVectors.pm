package CipherLab::Families::Caesar::CaesarVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from CaesarCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "DXYGJSJDOMJB"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "WLJWBQLUMDBKCVFP"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "GIKKULCRPQNGIMRDE"),
    );
}

1;
