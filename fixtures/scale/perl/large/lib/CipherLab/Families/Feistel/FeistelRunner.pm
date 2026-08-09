package CipherLab::Families::Feistel::FeistelRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Feistel::FeistelCipher;
use CipherLab::Families::Feistel::FeistelVectors;

sub check {
    my $cipher = CipherLab::Families::Feistel::FeistelCipher->new;
    my @vectors = CipherLab::Families::Feistel::FeistelVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
