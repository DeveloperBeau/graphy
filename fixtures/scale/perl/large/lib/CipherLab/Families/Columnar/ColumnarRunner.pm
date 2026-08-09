package CipherLab::Families::Columnar::ColumnarRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Columnar::ColumnarCipher;
use CipherLab::Families::Columnar::ColumnarVectors;

sub check {
    my $cipher = CipherLab::Families::Columnar::ColumnarCipher->new;
    my @vectors = CipherLab::Families::Columnar::ColumnarVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
