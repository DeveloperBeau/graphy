package CipherLab::Families::Substitution::SubstitutionVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from SubstitutionCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "GBDMQASNZYWP"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "ZPOCIYUEXPOYRLWH"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "JMPQBTLBACAUXCIVX"),
    );
}

1;
