package CipherLab::Families::NibbleSwap::NibbleSwapRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::NibbleSwap::NibbleSwapCipher;
use CipherLab::Families::NibbleSwap::NibbleSwapVectors;

sub check {
    my $cipher = CipherLab::Families::NibbleSwap::NibbleSwapCipher->new;
    my @vectors = CipherLab::Families::NibbleSwap::NibbleSwapVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
