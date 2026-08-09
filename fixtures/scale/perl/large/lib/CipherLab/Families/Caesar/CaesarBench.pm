package CipherLab::Families::Caesar::CaesarBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Caesar::CaesarCipher;
use CipherLab::Families::Caesar::CaesarVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Caesar::CaesarCipher->new;
    my @vectors = CipherLab::Families::Caesar::CaesarVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
