package CipherLab::Families::Columnar::ColumnarBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Columnar::ColumnarCipher;
use CipherLab::Families::Columnar::ColumnarVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Columnar::ColumnarCipher->new;
    my @vectors = CipherLab::Families::Columnar::ColumnarVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
