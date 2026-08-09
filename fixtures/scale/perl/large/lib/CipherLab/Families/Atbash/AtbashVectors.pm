package CipherLab::Families::Atbash::AtbashVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from AtbashCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "FBEOTEXTGGFZ"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "YPPELCZKEXXICXJV"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "IMQSEXQHHKJEIOVJM"),
    );
}

1;
