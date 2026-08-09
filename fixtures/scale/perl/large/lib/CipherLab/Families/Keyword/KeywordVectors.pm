package CipherLab::Families::Keyword::KeywordVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from KeywordCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "FZAILULFQOLD"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "YNLYDSNWOFDMEXHR"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "IKMMWNETRSPIKOTFG"),
    );
}

1;
