package CipherLab::Families::Polybius::PolybiusBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Polybius::PolybiusCipher;
use CipherLab::Families::Polybius::PolybiusVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Polybius::PolybiusCipher->new;
    my @vectors = CipherLab::Families::Polybius::PolybiusVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
