package CipherLab::Families::RotByte::RotByteVectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from RotByteCipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("The quick brown fox jumps ov", "576c6026767d6069602c6f7c60677f32757b6d367d6d746a683c7268"),
        CipherLab::TestVector->new("cipher test corpus", "606d756e627a297e6e7f792e6c7f63626667"),
        CipherLab::TestVector->new("0123456789abcdef", "33353735333d3f3d33356c6c6c747474"),
    );
}

1;
