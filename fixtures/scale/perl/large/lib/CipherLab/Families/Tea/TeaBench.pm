package CipherLab::Families::Tea::TeaBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Tea::TeaCipher;
use CipherLab::Families::Tea::TeaVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Tea::TeaCipher->new;
    my @vectors = CipherLab::Families::Tea::TeaVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
