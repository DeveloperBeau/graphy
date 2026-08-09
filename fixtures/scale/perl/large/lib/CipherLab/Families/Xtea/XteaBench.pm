package CipherLab::Families::Xtea::XteaBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Xtea::XteaCipher;
use CipherLab::Families::Xtea::XteaVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Xtea::XteaCipher->new;
    my @vectors = CipherLab::Families::Xtea::XteaVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
