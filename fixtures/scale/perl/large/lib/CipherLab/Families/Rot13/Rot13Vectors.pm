package CipherLab::Families::Rot13::Rot13Vectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from Rot13Cipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "EZBKOYQLXWUN"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "XNMAGWSCVNMWPJUF"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "HKNOZRJZYAYSVAGTV"),
    );
}

1;
