package CipherLab::Families::RotByte::RotByteRunner;
use strict;
use warnings;
use CipherLab::Engine::CorrectnessEngine;
use CipherLab::Families::RotByte::RotByteCipher;
use CipherLab::Families::RotByte::RotByteVectors;

sub check {
    my $cipher = CipherLab::Families::RotByte::RotByteCipher->new;
    my @vectors = CipherLab::Families::RotByte::RotByteVectors::all();
    return CipherLab::Engine::CorrectnessEngine::verify($cipher, @vectors);
}

1;
