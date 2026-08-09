package CipherLab::Families::XorRolling::XorRollingBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::XorRolling::XorRollingCipher;
use CipherLab::Families::XorRolling::XorRollingVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::XorRolling::XorRollingCipher->new;
    my @vectors = CipherLab::Families::XorRolling::XorRollingVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
