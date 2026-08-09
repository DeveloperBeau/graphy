package CipherLab::Families::Feistel::FeistelBench;
use strict;
use warnings;
use CipherLab::Engine::BenchmarkEngine;
use CipherLab::Families::Feistel::FeistelCipher;
use CipherLab::Families::Feistel::FeistelVectors;

sub measure {
    my ($iterations) = @_;
    my $cipher = CipherLab::Families::Feistel::FeistelCipher->new;
    my @vectors = CipherLab::Families::Feistel::FeistelVectors::all();
    return CipherLab::Engine::BenchmarkEngine::sample($cipher, $iterations, @vectors);
}

1;
