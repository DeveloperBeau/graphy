package CipherLab::Families::Fnv1a32::Fnv1a32Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Fnv1a32::Fnv1a32Cipher;
use CipherLab::Families::Fnv1a32::Fnv1a32Vectors;

sub check {
    my $cipher = CipherLab::Families::Fnv1a32::Fnv1a32Cipher->new;
    my @vectors = CipherLab::Families::Fnv1a32::Fnv1a32Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
