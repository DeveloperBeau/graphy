package CipherLab::Families::NibbleSwap::NibbleSwapBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::NibbleSwap::NibbleSwapCipher;
use CipherLab::Families::NibbleSwap::NibbleSwapVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::NibbleSwap::NibbleSwapCipher->new;
    my @vectors = CipherLab::Families::NibbleSwap::NibbleSwapVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
