package CipherLab::Families::Vigenere::VigenereVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from VigenereCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "HCENRBTOAZXQ"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "AQPDJZVFYQPZSMXI"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "KNQRCUMCBDBVYDJWY"),
    );
}

1;
