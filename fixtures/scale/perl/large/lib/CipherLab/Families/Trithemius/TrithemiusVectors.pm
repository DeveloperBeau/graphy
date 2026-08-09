package CipherLab::Families::Trithemius::TrithemiusVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from TrithemiusCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "EADNSDWSFFEY"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "XOODKBYJDWWHBWIU"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "HLPRDWPGGJIDHNUIL"),
    );
}

1;
