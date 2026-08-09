package CipherLab::Families::XorStatic::XorStaticBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::XorStatic::XorStaticCipher;
use CipherLab::Families::XorStatic::XorStaticVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::XorStatic::XorStaticCipher->new;
    my @vectors = CipherLab::Families::XorStatic::XorStaticVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
