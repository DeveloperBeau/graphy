package CipherLab::Families::Rc4::Rc4Vectors;
use strict;
use warnings;
use CipherLab::TestVector;

# Known-answer test data captured from Rc4Cipher's own encode.
sub all {
    return (
        CipherLab::TestVector->new("The quick brown fox jumps ov", "53606c2a7a79646d643073607c637b367177613a7169706e6c004e54"),
        CipherLab::TestVector->new("cipher test corpus", "646179626e7e2d7a6a636532707b6766626b"),
        CipherLab::TestVector->new("0123456789abcdef", "37393b393f393b393729707070707070"),
    );
}

1;
