package CipherLab::Families::BlockReverse::BlockReverseRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::BlockReverse::BlockReverseCipher;
use CipherLab::Families::BlockReverse::BlockReverseVectors;

sub check {
    my $cipher = CipherLab::Families::BlockReverse::BlockReverseCipher->new;
    my @vectors = CipherLab::Families::BlockReverse::BlockReverseVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
