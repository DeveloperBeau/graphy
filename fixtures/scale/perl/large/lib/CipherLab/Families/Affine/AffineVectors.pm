package CipherLab::Families::Affine::AffineVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from AffineCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("ATTACKATDAWN", "GABJMVMGRPME"),
        CipherLab::TestVector->new("THEQUICKBROWNFOX", "ZOMZETOXPGENFYIS"),
        CipherLab::TestVector->new("DEFENDTHEEASTWALL", "JLNNXOFUSTQJLPUGH"),
    );
}

1;
