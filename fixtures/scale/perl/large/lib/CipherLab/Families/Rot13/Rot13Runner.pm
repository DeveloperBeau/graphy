package CipherLab::Families::Rot13::Rot13Runner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::Rot13::Rot13Cipher;
use CipherLab::Families::Rot13::Rot13Vectors;

sub check {
    my $cipher = CipherLab::Families::Rot13::Rot13Cipher->new;
    my @vectors = CipherLab::Families::Rot13::Rot13Vectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
