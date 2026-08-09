package CipherLab::Families::Autokey::AutokeyVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from AutokeyCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "IEHRWHAWJJIC"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "BSSHOFCNHAALFAMY"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "LPTVHATKKNMHLRYMP"),
    );
}

1;
