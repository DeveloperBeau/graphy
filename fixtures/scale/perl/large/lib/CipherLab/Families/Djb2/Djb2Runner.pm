package CipherLab::Families::Djb2::Djb2Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Djb2::Djb2Cipher;
use CipherLab::Families::Djb2::Djb2Vectors;

sub check {
    my $cipher = CipherLab::Families::Djb2::Djb2Cipher->new;
    my @vectors = CipherLab::Families::Djb2::Djb2Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
