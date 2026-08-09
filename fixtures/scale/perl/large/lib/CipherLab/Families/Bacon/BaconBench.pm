package CipherLab::Families::Bacon::BaconBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Bacon::BaconCipher;
use CipherLab::Families::Bacon::BaconVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Bacon::BaconCipher->new;
    my @vectors = CipherLab::Families::Bacon::BaconVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
