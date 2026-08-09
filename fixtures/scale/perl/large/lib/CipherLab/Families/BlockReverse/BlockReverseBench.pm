package CipherLab::Families::BlockReverse::BlockReverseBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::BlockReverse::BlockReverseCipher;
use CipherLab::Families::BlockReverse::BlockReverseVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::BlockReverse::BlockReverseCipher->new;
    my @vectors = CipherLab::Families::BlockReverse::BlockReverseVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
