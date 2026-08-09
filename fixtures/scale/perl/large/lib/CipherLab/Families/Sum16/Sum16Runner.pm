package CipherLab::Families::Sum16::Sum16Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Sum16::Sum16Cipher;
use CipherLab::Families::Sum16::Sum16Vectors;

sub check {
    my $cipher = CipherLab::Families::Sum16::Sum16Cipher->new;
    my @vectors = CipherLab::Families::Sum16::Sum16Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
