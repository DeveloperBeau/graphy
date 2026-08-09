package CipherLab::Families::Beaufort::BeaufortVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from BeaufortCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "JDEMPYPJUSPH"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "CRPCHWRASJHQIBLV"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "MOQQARIXVWTMOSXJK"),
    );
}

1;
