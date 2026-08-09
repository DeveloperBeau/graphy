package CipherLab::Families::Columnar::ColumnarVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from ColumnarCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "JEGPTDVQCBZS"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "CSRFLBXHASRBUOZK"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "MPSTEWOEDFDXAFLYA"),
    );
}

1;
